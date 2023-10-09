// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "ERC20.sol";
import "ERC20Burnable.sol";

contract FairToken is ERC20, ERC20Burnable {
    uint256 public pool = 0;
    uint16 public reward = 20000;
    uint256 public lastblock = 0;

    constructor() ERC20("FAIR", "FAIR") {}
    
    receive() external payable {
        require(msg.value == 0);

        if (block.number >= 110700000) {

            if(lastblock + 1800 < block.number) {
                pool = pool + reward*(10 ** uint256(decimals()));
                lastblock = block.number;
                if (reward > 0) reward = reward - 1;
            }

            uint256 tosend = pool / 1000;

            if ((tosend == 0) && (pool > 0)) tosend = 1;

            if (tosend > 0) {
                _mint(msg.sender, tosend);
                pool = pool - tosend;
            }
        }
    }    
}