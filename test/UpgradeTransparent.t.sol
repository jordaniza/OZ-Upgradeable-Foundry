// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.12;

import {PRBTest} from "@prb/test/PRBTest.sol";
import "@std/console.sol";
import "@oz/proxy/transparent/TransparentUpgradeableProxy.sol";
import "@oz/proxy/transparent/ProxyAdmin.sol";

import "../src/UpgradeTransparent.sol";

contract _Test is PRBTest {
    MyContract implementationV1;
    TransparentUpgradeableProxy proxy;
    MyContract wrappedProxyV1;
    MyContractV2 wrappedProxyV2;
    ProxyAdmin admin;

    function setUp() public {
        admin = new ProxyAdmin();

        implementationV1 = new MyContract();

        // deploy proxy contract and point it to implementation
        proxy = new TransparentUpgradeableProxy(address(implementationV1), address(admin), "");

        // wrap in ABI to support easier calls
        wrappedProxyV1 = MyContract(address(proxy));

        wrappedProxyV1.initialize(100);
    }

    function testCanInitialize() public {
        assertEq(wrappedProxyV1.x(), 100);
    }

    function testCanUpgrade() public {
        MyContractV2 implementationV2 = new MyContractV2();
        admin.upgrade(proxy, address(implementationV2));

        // re-wrap the proxy
        wrappedProxyV2 = MyContractV2(address(proxy));

        assertEq(wrappedProxyV2.x(), 100);

        wrappedProxyV2.setY(200);
        assertEq(wrappedProxyV2.y(), 200);
    }

    function testOnlyInitializeOnce() public {
        vm.expectRevert("Initializable: contract is already initialized");
        wrappedProxyV1.initialize(100);
    }
}
