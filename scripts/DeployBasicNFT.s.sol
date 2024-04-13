// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.22;

import {Script} from "forge-std/Script.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract DeployBasicNFT is Script {
    BasicNFT public basicNFT;

    function run() external returns (BasicNFT) {
        vm.startBroadcast();
        basicNFT = new BasicNFT();
        vm.stopBroadcast();
        return basicNFT;
    }
}
