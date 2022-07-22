// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.14;

import {PRBTest} from "@prb/test/PRBTest.sol";
import "@std/console.sol";

import "../src/Upgrade.sol";

contract _Test is PRBTest {
    MyContract test;
    UUPSProxy proxy;
    MyContract _contract;
    MyContractV2 __contract;

    function setUp() public {
        test = new MyContract();
        // deploy proxy contract and point it to implementation

        proxy = new UUPSProxy(address(test), "");

        // wrap in ABI to support easier calls
        _contract = MyContract(address(proxy));
    }

    function testCanInitialize() public {
        assertEq(_contract.x(), 0);
        _contract.initialize(100);
        assertEq(_contract.x(), 100);
    }

    function testCanUpgrade() public {
        MyContractV2 testNew = new MyContractV2();

        _contract.initialize(100);

        _contract.upgradeTo(address(testNew));

        // re-wrap the proxy
        __contract = MyContractV2(address(proxy));

        assertEq(__contract.x(), 100);

        __contract.setY(200);
        assertEq(__contract.y(), 200);
    }
}
