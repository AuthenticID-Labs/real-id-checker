//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@authenticid-labs/realid-registrar/contracts/MyRegistrar.sol";

contract RealIDChecker {
    MyRegistrar private registrar;
    address private owner;

    constructor(address _address) {
        owner = msg.sender;
        registrar = MyRegistrar(_address);
    }

    modifier onlyRealID() {
        require(registrar.hasHash(msg.sender), "RealID Only");
        _;
    }

    function hasRealID(address toCheck) public view returns (bool realid) {
        return registrar.hasHash(toCheck);
    }

    function updateRegistrarAddress(address _registrarAddress) public {
        require(msg.sender == owner, 'owner only');
        registrar = MyRegistrar(_registrarAddress);
    }
}