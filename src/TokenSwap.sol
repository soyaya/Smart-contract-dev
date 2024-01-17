// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
 
contract TokenSwap {
    using SafeMath for uint256;

    struct TokenInfo {
        IERC20 token;
        uint256 conversionRate;
    }

    mapping(string => TokenInfo) public tokenInfoMapping;

    function addToken(string memory _symbol, address _tokenAddress, uint256 _rate) public {
        IERC20 newToken = IERC20(_tokenAddress);
        tokenInfoMapping[_symbol] = TokenInfo(newToken, _rate);
    }

    function performSwap(string memory _from, string memory _to, uint256 _amount) public {
        require(tokenInfoMapping[_from].token.balanceOf(msg.sender) >= _amount, "Insufficient balance");

        uint256 amountToReceive = _amount.mul(tokenInfoMapping[_to].conversionRate).div(tokenInfoMapping[_from].conversionRate);

        tokenInfoMapping[_from].token.transferFrom(msg.sender, address(this), _amount);
        tokenInfoMapping[_to].token.transfer(msg.sender, amountToReceive);
    }

    function updateConversionRate(string memory _symbol, uint256 _newRate) public {
        tokenInfoMapping[_symbol].conversionRate = _newRate;
    }
}
