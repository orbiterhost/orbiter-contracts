// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import {Test, console} from "forge-std/Test.sol";
import {OrbiterSite} from "../src/OrbiterSite.sol";
import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract OrbiterSiteTest is Test {
    OrbiterSite public orbiterSite;
    address owner = address(1);
    string testCid = "QmTest123";

    function setUp() public {
        vm.prank(owner);
        orbiterSite = new OrbiterSite();
        vm.startPrank(owner);
    }

    function testSetValue() public {
        orbiterSite.updateMapping(testCid);
        assertEq(orbiterSite.getMapping(), testCid);
    }

    function testOnlyOwnerCanSetValue() public {
        vm.stopPrank();
        vm.prank(address(2));
        vm.expectRevert(
            abi.encodeWithSignature(
                "OwnableUnauthorizedAccount(address)",
                address(2)
            )
        );
        orbiterSite.updateMapping(testCid);
    }

    function testEmitsEvent() public {
        vm.expectEmit(true, true, true, true);
        emit OrbiterSite.MappingUpdated(testCid);
        orbiterSite.updateMapping(testCid);
    }

    function testGetValue() public {
        orbiterSite.updateMapping(testCid);
        string memory initialValue = orbiterSite.getMapping();
        assertEq(initialValue, testCid);

        string memory newTestCid = "QmTest456";
        orbiterSite.updateMapping(newTestCid);
        string memory newValue = orbiterSite.getMapping();
        assertEq(newValue, newTestCid);
    }
}
