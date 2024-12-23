// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../src/OrbiterFactory.sol";
import "../lib/forge-std/src/Test.sol";

contract OrbiterFactoryTest is Test {
    OrbiterFactory public factory;

    function setUp() public {
        factory = new OrbiterFactory();
    }

    function testCreateHelloBase() public {
        address deployedSite = factory.createHelloBase();
        assertTrue(deployedSite != address(0));

        vm.expectEmit(true, false, false, false);
        emit OrbiterFactory.OrbiterSiteCreated(deployedSite);
        factory.createHelloBase();
    }

    function testImplementationAddress() public view {
        assertTrue(factory.implementation() != address(0));
    }
}
