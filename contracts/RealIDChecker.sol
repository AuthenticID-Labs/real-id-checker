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

    function verify(
        address addy,
        bytes32[] memory proof,
        bytes32 leaf,
        uint index
    ) public view returns (bool) {
        bytes32 root = registrar.getHash(addy);
        bytes32 hash = leaf;

        for (uint i = 0; i < proof.length; i++) {
            bytes32 proofElement = proof[i];

            if (index % 2 == 0) {
                hash = sha256(abi.encodePacked(hash, proofElement));
            } else {
                hash = sha256(abi.encodePacked(proofElement, hash));
            }

            index = index / 2;
        }

        return hash == root;
    }
}