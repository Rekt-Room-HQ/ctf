// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function transfer(address, uint256) external returns (bool);
    function transferFrom(address, address, uint256) external returns (bool);
}

interface IUniswapV2Pair {
    function getReserves() external view returns (uint112, uint112, uint32);
    function token0() external view returns (address);
}

/// @notice INTENTIONALLY VULNERABLE. For the CTF only. Never deploy.
contract VulnerableLender {
    IUniswapV2Pair public immutable pair;
    IERC20 public immutable weth;
    IERC20 public immutable usdc;
    bool private immutable wethIsToken0;

    uint256 public constant LTV = 75; // max borrow, % of collateral value

    mapping(address => uint256) public collateral; // WETH deposited
    mapping(address => uint256) public debt;       // USDC borrowed

    constructor(address _pair, address _weth, address _usdc) {
        pair = IUniswapV2Pair(_pair);
        weth = IERC20(_weth);
        usdc = IERC20(_usdc);
        wethIsToken0 = IUniswapV2Pair(_pair).token0() == _weth;
    }

    function deposit(uint256 amount) external {
        require(weth.transferFrom(msg.sender, address(this), amount), "transfer failed");
        collateral[msg.sender] += amount;
    }

    function borrow(uint256 amount) external {
        uint256 maxBorrow = (collateralValue(msg.sender) * LTV) / 100;
        require(debt[msg.sender] + amount <= maxBorrow, "undercollateralized");
        debt[msg.sender] += amount;
        require(usdc.transfer(msg.sender, amount), "transfer failed");
    }

    function collateralValue(address user) public view returns (uint256) {
        (uint112 r0, uint112 r1, ) = pair.getReserves();
        (uint256 wethReserve, uint256 usdcReserve) = wethIsToken0
            ? (uint256(r0), uint256(r1))
            : (uint256(r1), uint256(r0));
        return (collateral[user] * usdcReserve) / wethReserve;
    }
}
