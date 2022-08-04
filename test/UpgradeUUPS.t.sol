// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.12;

import {PRBTest} from "@prb/test/PRBTest.sol";
import "@std/console.sol";

import "../src/UpgradeUUPS.sol";

contract _Test is PRBTest {
    MyContract implementationV1;
    UUPSProxy proxy;
    MyContract wrappedProxyV1;
    MyContractV2 wrappedProxyV2;

    function setUp() public {
        implementationV1 = new MyContract();
        // deploy proxy contract and point it to implementation

        proxy = new UUPSProxy(address(implementationV1), "");

        // wrap in ABI to support easier calls
        wrappedProxyV1 = MyContract(address(proxy));

        wrappedProxyV1.initialize(100);
    }

    function testCanInitialize() public {
        assertEq(wrappedProxyV1.x(), 100);
    }

    function testCanUpgrade() public {
        MyContractV2 implementationV2 = new MyContractV2();
        wrappedProxyV1.upgradeTo(address(implementationV2));

        // re-wrap the proxy
        wrappedProxyV2 = MyContractV2(address(proxy));

        assertEq(wrappedProxyV2.x(), 100);

        wrappedProxyV2.setY(200);
        assertEq(wrappedProxyV2.y(), 200);
    }
}
