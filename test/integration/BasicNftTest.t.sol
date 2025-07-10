// SPDX-License-Identifier: SEE LICENSE IN LICENSE

pragma solidity 0.8.30;

import {Script} from "forge-std/Script.sol";
import {DeployBasicNft} from "script/DeployBasicNft.s.sol";
import {BasicNft} from "src/BasicNft.sol";

contract BasicNftTest is Script {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public COLLECTOR = makeAddr("collector");
    string public constant PIXEL = "ipfs://dino.png";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Pixel";
        string memory actualName = basicNft.name();
        // Strings cannot be compared directly -> compare their hashes
        assert(keccak256(abi.encode(expectedName)) == keccak256(abi.encode(actualName)));
    }

    function testCanMintAndHaveABalance() public {
        // Arrange
        vm.prank(COLLECTOR);
        // Act
        basicNft.mintNft(PIXEL);
        // Assert
        assert(keccak256(abi.encodePacked(basicNft.tokenURI(0))) == keccak256(abi.encodePacked(PIXEL)));
    }
}
