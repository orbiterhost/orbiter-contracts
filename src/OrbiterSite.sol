// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.23;

import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract OrbiterSite is Ownable {
    string private cidMapping;
    bool private initialized;

    constructor() Ownable(msg.sender) {}

    function initialize(address owner) external {
        require(!initialized, "Already initialized");
        _transferOwnership(owner);
        initialized = true;
    }

    event MappingUpdated(string value);

    function updateMapping(string memory value) public onlyOwner {
        cidMapping = value;
        emit MappingUpdated(value);
    }

    function getMapping() public view returns (string memory) {
        return cidMapping;
    }
}
