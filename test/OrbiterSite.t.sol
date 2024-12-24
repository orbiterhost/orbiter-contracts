// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Test, console} from "forge-std/Test.sol";
import {OrbiterSite} from "../src/OrbiterSite.sol";
import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract OrbiterSiteTest is Test {
    OrbiterSite public orbiterSite;
    address user = address(0x1);

    function setUp() public {
        orbiterSite = new OrbiterSite();
    }

    function testInitialize() public {
        orbiterSite.initialize(user);
        assertEq(orbiterSite.owner(), user);
    }

    function testCantInitializeTwice() public {
        orbiterSite.initialize(user);
        vm.expectRevert("Already initialized");
        orbiterSite.initialize(user);
    }

    function testUpdateMapping() public {
        orbiterSite.initialize(user);
        vm.prank(user);
        orbiterSite.updateMapping("newCID");
        assertEq(orbiterSite.getMapping(), "newCID");
    }

    function testOnlyOwnerCanUpdateMapping() public {
        orbiterSite.initialize(user);
        vm.startPrank(address(0x2));
        vm.expectRevert(
            abi.encodeWithSelector(
                Ownable.OwnableUnauthorizedAccount.selector,
                address(0x2)
            )
        );
        orbiterSite.updateMapping("newCID");
        vm.stopPrank();
    }

    function testGetMapping() public {
        orbiterSite.initialize(user);
        vm.prank(user);
        orbiterSite.updateMapping("testCID");
        assertEq(orbiterSite.getMapping(), "testCID");
    }

    function testMappingUpdatedEvent() public {
        orbiterSite.initialize(user);
        vm.prank(user);
        emit MappingUpdated("newCID");
        orbiterSite.updateMapping("newCID");
    }

    event MappingUpdated(string value);
}
