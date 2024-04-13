// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.22;

import {Test, console} from "forge-std/Test.sol";
import {DeployBasicNFT} from "../../scripts/DeployBasicNFT.s.sol";
import {BasicNFT} from "../../src/BasicNFT.sol";

contract TestBasicNFT is Test {
    DeployBasicNFT public deployer;
    BasicNFT public basicNFT;
    address public USER = makeAddr("user");
    string public PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() external {
        deployer = new DeployBasicNFT();
        basicNFT = deployer.run();
    }

    // TESTS!!
    function testNameIsAccurate() public {
        string memory ExpectedName = "Doggie";
        string memory ActualName = basicNFT.name();
        //ExpectedName == ActualName;
        // But strings can't br compoared directly, so we have to hash them
        assertEq(
            keccak256(abi.encodePacked(ExpectedName)),
            keccak256(abi.encodePacked(ActualName))
        );
    }

    function testCanMintNFT() external {
        //Arrange
        vm.prank(USER);
        //Act
        basicNFT.mint(PUG);
        //Assert
        assertEq(basicNFT.balanceOf(USER), 1);
        assertEq(
            keccak256(abi.encodePacked(PUG)),
            keccak256(abi.encodePacked(basicNFT.tokenURI(0)))
        );
    }
}
