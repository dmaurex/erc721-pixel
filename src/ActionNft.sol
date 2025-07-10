// SPDX-License-Identifier: SEE LICENSE IN LICENSE

pragma solidity 0.8.30;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {console} from "forge-std/console.sol";
//import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract ActionNft is ERC721 {
    uint256 private s_tokenCounter; // token ID of the next NFT that will be minted
    string private s_runSvgImageUri;
    string private s_stopSvgImageUri;

    enum Action {
        RUN,
        STOP
    }

    mapping(uint256 => Action) private s_tokenIdToAction;

    event CreatedNft(uint256 indexed tokenId);

    constructor(string memory runSvgImageUri, string memory stopSvgImageUri) ERC721("Pixel", "PIX") {
        s_tokenCounter = 0;
        s_runSvgImageUri = runSvgImageUri;
        s_stopSvgImageUri = stopSvgImageUri;
    }

    function mintNft() public {
        // Here a payment could be required for minting an NFT
        uint256 tokenCounter = s_tokenCounter;
        _safeMint(msg.sender, tokenCounter);
        s_tokenCounter++;
        emit CreatedNft(tokenCounter);
    }

    function flipAction(uint256 tokenId) public {
        // Only authorized address can change action
        address owner = ownerOf(tokenId);
        _checkAuthorized(owner, msg.sender, tokenId);

        if (s_tokenIdToAction[tokenId] == Action.RUN) {
            s_tokenIdToAction[tokenId] = Action.STOP;
        } else {
            s_tokenIdToAction[tokenId] = Action.RUN;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageUri;
        if (s_tokenIdToAction[tokenId] == Action.RUN) {
            imageUri = s_runSvgImageUri;
        } else {
            imageUri = s_stopSvgImageUri;
        }

        string memory tokenMetadata = string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    abi.encodePacked(
                        '{"name":"',
                        name(),
                        '", "description":"An NFT that reflects the action of the owner, 100% on Chain!", ',
                        '"attributes": [{"trait_type": "action", "value": 100}], "image":"',
                        imageUri,
                        '"}'
                    )
                )
            )
        );
        return tokenMetadata;
    }
}
