// An NFT Contract 
// Where the tokenURI can be one of 3 differnet dogs
// Randomly selected

// SPDX-License-Identifier: MIT
pragma solidity 0.6.6;

import "@openzeppelin/contracts/token/ERC721.sol";
import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";

contract AdvancedCollectibe is ERC721, VRFConsumerBase{
    uint256 public tokenCounter;
    bytes32 public keyhash;
    uint256 public fee;
    enum Breed{PUG, SHIBA_INU, ST_BERNARD}
    mapping(uint256 => Breed) public tokenIdToBreed;
    mapping(bytes32 => address) public requestIdToSender;
    event requestedCollectibe(bytes32 indexed requestId, address requester);
    event breedAssigned(uint256 indexed tokenid, Breed breed);

    constructor(address _vrfCoordinator, address _linkToken, bytes32 _keyhas, uint256_ fee) public
    VRFConsumerBase(_vrfCoordinator, _linkToken)
    ERC721("Dogie", "DOG)
    {
        tokenCounter = 0;
        keyhash = _keyhash;
        fee = _fee;
    }

    function createCollectible() public returns (bytes32){
        bytes32 requestId = rquestRandomness(keyhas, fee);
        requestIdToSender[requestId = msg.sender;
        emit requestedCollectible(requestId, msg.sender);
    }

    function fulfillRandomness(bytes32 requestId, uint256  randomNumber) internal oveverride{
        Breed breed = breed = Breed(randomNumber % 3);
        uint256 newTokenId = tokenCounter;
        tokenIdToBreed[newTokenId] = breed;
        emit breedAssigned(newTokenId, breed)
        address owner = requestIdToSenser[requestId];
        _safeMint(owner, newTokenId);
        tokenCounter = tokenCounter + 1;
    }

    function setTokenURI(uint256 tokenId, string memory _tokenURI) public{
        // pug, shiba inu, st benard
        require(_isApprovedorOwner(_msgSender(), tokenId), "ERC721: caller is not ownner or not approved");
        _setTokenURI(tokenId, _tokenURI)
    }
}