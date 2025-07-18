// SPDX-License-Identifier: SEE LICENSE IN LICENSE

pragma solidity 0.8.30;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "src/BasicNft.sol";
import {ActionNft} from "src/ActionNft.sol";

contract MintBasicNft is Script {
    string public constant PIXEL = "ipfs://dino.png"; // <-- Insert a valid IPFS URL

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(PIXEL);
        vm.stopBroadcast();
    }
}

contract MintActionNft is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("ActionNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployed);
        console.log("Contract Address: ", mostRecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        ActionNft(contractAddress).mintNft();
        vm.stopBroadcast();
    }
}

contract FlipActionNft is Script {
    uint256 public constant FLIPPED_TOKEN_ID = 0;

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("ActionNft", block.chainid);
        flipActionNft(mostRecentlyDeployed, FLIPPED_TOKEN_ID);
        console.log("Contract Address: ", mostRecentlyDeployed);
        console.log("Token ID: ", FLIPPED_TOKEN_ID);
    }

    function flipActionNft(address contractAddress, uint256 tokenId) public {
        vm.startBroadcast();
        ActionNft(contractAddress).flipAction(tokenId);
        vm.stopBroadcast();
    }
}
