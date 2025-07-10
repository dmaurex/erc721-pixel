// SPDX-License-Identifier: SEE LICENSE IN LICENSE

pragma solidity 0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {ActionNft} from "src/ActionNft.sol";
import {Base64} from "openzeppelin-contracts/contracts/utils/Base64.sol";

contract DeployActionNft is Script {
    function run() external returns (ActionNft) {
        string memory runSvg = vm.readFile("./img/dino_run.svg");
        string memory stopSvg = vm.readFile("./img/dino_stop.svg");
        console.log(runSvg);

        vm.startBroadcast();
        ActionNft actionNft = new ActionNft(svgToImageUri(runSvg), svgToImageUri(stopSvg));
        vm.stopBroadcast();
        return actionNft;
    }

    function svgToImageUri(string memory svg) public pure returns (string memory) {
        // Example
        // From: <svg version="1.1" width="144" height="163">...
        // To: data:image/svg+xml;base64,PD94bWwg...
        string memory baseUrl = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));
        return string(abi.encodePacked(baseUrl, svgBase64Encoded));
    }
}
