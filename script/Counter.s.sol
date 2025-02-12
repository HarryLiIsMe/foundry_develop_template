// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";

contract CounterScript is Script {
    Counter public counter;

    function setUp() public {
        address counterAddr = vm.envAddress("COUNTER_DEPLOY_ADDR");
        counter = Counter(payable(counterAddr));
    }

    function run() public returns (uint256) {
        // The vm.startBroadcast() + vm.stopBroadcast() is able to broadcast multiple transactions at once(execute multiple contract methods\functions).
        vm.startBroadcast();

        console.log("counter: ", counter.number());

        console.log("counter increment");
        counter.increment();
        console.log("counter: ", counter.number());

        console.log("counter setNumber 99");
        counter.setNumber(99);
        console.log("counter: ", counter.number());

        vm.stopBroadcast();

        return 10;
    }

    function run(
        uint256 v1
    ) public returns (uint256) {
        // The vm.broadcast() is used to broadcast single transaction(execute single contract method\function).
        vm.broadcast();

        return v1;
    }
}
