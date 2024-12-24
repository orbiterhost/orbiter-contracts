// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../src/OrbiterFactory.sol";
import "../lib/forge-std/src/Test.sol";

contract OrbiterFactoryTest is Test {
    OrbiterFactory factory;

    function setUp() public {
        factory = new OrbiterFactory();
    }

    function testCreateSite() public {
        address site = factory.createHelloBase();

        assertNotEq(site, address(0));
        assertNotEq(site, factory.implementation());

        OrbiterSite orbiterSite = OrbiterSite(site);
        assertEq(orbiterSite.owner(), address(this));

        string memory testCid = "Qm123";
        orbiterSite.updateMapping(testCid);
        assertEq(orbiterSite.getMapping(), testCid);
    }

    function testCreateMultipleSites() public {
        address site1 = factory.createHelloBase();
        address site2 = factory.createHelloBase();

        assertNotEq(site1, site2);

        OrbiterSite orbiterSite1 = OrbiterSite(site1);
        OrbiterSite orbiterSite2 = OrbiterSite(site2);

        string memory testCid1 = "Qm123";
        string memory testCid2 = "Qm456";

        orbiterSite1.updateMapping(testCid1);
        orbiterSite2.updateMapping(testCid2);

        assertEq(orbiterSite1.getMapping(), testCid1);
        assertEq(orbiterSite2.getMapping(), testCid2);
    }
}
