// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/Invest.sol";

contract Deploy is Script {
    function run() external {
        vm.startBroadcast();

        new InvestMoney(
            0x4daE06AC2bB887247Adc110Ba28BB0f35f07BFF2,
            "nobitakaif",
            "This is deploying the contract",
            100,
            4
        );

        vm.stopBroadcast();
    }
}
