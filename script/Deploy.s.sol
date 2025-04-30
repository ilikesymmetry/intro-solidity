// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Attendance} from "../src/Attendance.sol";

contract Deploy is Script {
    function run() public {
        vm.startBroadcast();

        address owner = msg.sender;
        // address owner = 0x2B654aB28f82a2a4E4F6DB8e20791E5AcF4125c6; // webapp wallet
        new Attendance(owner);

        vm.stopBroadcast();
    }
}
