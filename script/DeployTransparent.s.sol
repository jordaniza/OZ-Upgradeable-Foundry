// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.12;

import "@std/console.sol";
import "@std/Script.sol";
import "@oz/proxy/transparent/TransparentUpgradeableProxy.sol";
import "@oz/proxy/transparent/ProxyAdmin.sol";
import "../src/UpgradeTransparent.sol";

contract DeployTransparent is Script {
    MyContract implementationV1;
    TransparentUpgradeableProxy proxy;
    MyContract wrappedProxyV1;
    MyContractV2 wrappedProxyV2;
    ProxyAdmin admin;

    function run() public {
        admin = new ProxyAdmin();

        implementationV1 = new MyContract();
        
        // deploy proxy contract and point it to implementation
        proxy = new TransparentUpgradeableProxy(address(implementationV1), address(admin), "");
        
        // wrap in ABI to support easier calls
        wrappedProxyV1 = MyContract(address(proxy));
        wrappedProxyV1.initialize(100);


        // expect 100
        console.log(wrappedProxyV1.x());

        // new implementation
        MyContractV2 implementationV2 = new MyContractV2();
        admin.upgrade(proxy, address(implementationV2));
        
        wrappedProxyV2 = MyContractV2(address(proxy));
        wrappedProxyV2.setY(200);

        console.log(wrappedProxyV2.x(), wrappedProxyV2.y());
    }

}
