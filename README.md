# Real ID dot ETH Hardhat Project

Contracts and scripts for AuthenticID Labs realid.eth identity products


```
//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./RealIDChecker.sol";
import "hardhat/console.sol";

contract Greeter is RealIDChecker {
    string private greeting;
    address private owner;

    constructor(string memory _greeting, address _registrarAddress) RealIDChecker(_registrarAddress) {
        console.log("Deploying a Greeter with greeting:", _greeting);
        owner = msg.sender;
        greeting = _greeting;
    }

    function greet() public view onlyRealID() returns (string memory) {
        return greeting;
    }

    function setGreeting(string memory _greeting) public {
        console.log("Changing greeting from '%s' to '%s'", greeting, _greeting);
        greeting = _greeting;
    }
}
```


