// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";

contract CounterScript is Script {
    function setUp() public {}

    function run() public returns (uint256) {
        vm.broadcast();
        return 10;
    }

    function run(uint256 v1) public returns (uint256) {
        vm.broadcast();
        return v1;
    }
}
