// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.12;

import "@std/console.sol";
import "@std/Script.sol";

import "../src/UpgradeUUPS.sol";

contract DeployUUPS is Script {
    UUPSProxy proxy;
    MyContract wrappedProxyV1;
    MyContractV2 wrappedProxyV2;

    function run() public {
        MyContract implementationV1 = new MyContract();
        
        // deploy proxy contract and point it to implementation
        proxy = new UUPSProxy(address(implementationV1), "");
        
        // wrap in ABI to support easier calls
        wrappedProxyV1 = MyContract(address(proxy));
        wrappedProxyV1.initialize(100);


        // expect 100
        console.log(wrappedProxyV1.x());

        // new implementation
        MyContractV2 implementationV2 = new MyContractV2();
        wrappedProxyV1.upgradeTo(address(implementationV2));
        
        wrappedProxyV2 = MyContractV2(address(proxy));
        wrappedProxyV2.setY(200);

        console.log(wrappedProxyV2.x(), wrappedProxyV2.y());
    }

}
