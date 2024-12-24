// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../lib/openzeppelin-contracts/contracts/proxy/Clones.sol";
import "./OrbiterSite.sol";

contract OrbiterFactory {
    address public immutable implementation;

    event OrbiterSiteCreated(address cloneAddress);

    constructor() {
        implementation = address(new OrbiterSite());
    }

    function createOrbitalSite() external returns (address) {
        address clone = Clones.clone(implementation);
        OrbiterSite(clone).initialize(msg.sender);

        emit OrbiterSiteCreated(clone);

        return clone;
    }
}
