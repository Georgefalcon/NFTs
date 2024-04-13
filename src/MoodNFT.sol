// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.22;

import {ERC721} from "openzepplin-contracts/contracts/token/ERC721/ERC721.sol";
import {Base64} from "openzepplin-contracts/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {
    //error
    error MoodNFT__CantFlipMoodIfNotOwner();
    uint256 private s_tokenCounter;
    string private s_happySvgImageUri;
    string private s_sadSvgImageUri;
    mapping(uint256 => Mood) private s_tokenIdToMood;
    enum Mood {
        HAPPY, // 0
        SAD // 1
    }

    constructor(
        string memory happySvgImageUri,
        string memory sadSvgImageUri
    ) ERC721("MoodNFT", "MN") {
        s_tokenCounter = 0;
        s_happySvgImageUri = happySvgImageUri;
        s_sadSvgImageUri = sadSvgImageUri;
    }

    function mint() external {
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
        _safeMint(msg.sender, s_tokenCounter);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function flipMood(uint256 tokenId) public {
        // Only NFT Owner is capable of flipping mood
        if (!_isApprovedOrOwner(msg.sender, tokenId)) {
            revert MoodNFT__CantFlipMoodIfNotOwner();
        }
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] == Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] == Mood.HAPPY;
        }
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURI;
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = s_sadSvgImageUri;
        } else {
            imageURI = s_happySvgImageUri;
        }
        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes( // bytes casting actually unnecessary as 'abi.encodePacked()' returns a bytes
                            abi.encodePacked(
                                '{"name":"',
                                name(), // You can add whatever name here
                                '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                                '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
