// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "../lib/forge-std/src/Script.sol";

import {Counter} from "../src/Counter.sol";
import {PermissionedCounter} from "../src/PermissionedCounter.sol";

contract PermissionedCounterScript is Script {
    Counter public counter;
    PermissionedCounter public permissionedCounter;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        counter = new Counter();
        permissionedCounter = new PermissionedCounter(address(counter));

        console.log("Counter deployed at", address(counter));
        console.log("PermissionedCounter deployed at", address(permissionedCounter));

        vm.stopBroadcast();
    }
}

// "deploy": forge script script/PermissionedCounter.s.sol:PermissionedCounterScript --rpc-url '' --chain-id 84532  --private-key '' --etherscan-api-key '' --verify --broadcast
