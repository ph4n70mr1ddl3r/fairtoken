// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "ERC20.sol";
import "ERC20Burnable.sol";

contract FairToken is ERC20, ERC20Burnable {
    uint256 public pool = 0;
    uint16 public increment = 20000;
    uint256 public lastblock = 0;

    constructor() ERC20("FAIR", "FAIR") {}
    
    receive() external payable {
        require(msg.value == 0);

        if (block.number >= 110700000) {

            if(lastblock + 1800 < block.number) {
                pool = pool + increment*(10 ** uint256(decimals()));
                lastblock = block.number;
                if (increment > 0) increment = increment - 1;
            }

            uint256 claim = pool / 1000;

            if ((claim == 0) && (pool > 0)) claim = 1;

            if (claim > 0) {
                _mint(msg.sender, claim);
                pool = pool - claim;
            }
        }
    }    
}