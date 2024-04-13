// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.22;

import {ERC721} from "openzepplin-contracts/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToUri;

    constructor() ERC721("Doggie", "DOG") {
        s_tokenCounter = 0;
    }

    function mint(string memory tokenUri) external {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        s_tokenCounter++;
        _safeMint(msg.sender, s_tokenCounter);
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return s_tokenIdToUri[tokenId];
        // return  "ipfs://QmZDVDxY1LWNkoK3vyi8LM4qmBC2sWatvhtdGFfyZY2rEA";
    }
}
