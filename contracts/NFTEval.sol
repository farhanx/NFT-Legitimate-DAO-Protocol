pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ALPDAO.sol";


contract NFTEvaluation is Ownable{

    // Struct to store NFT information
    struct NFT {
        address contractAddress;
        uint256 tokenId;
        uint256 votesFor;
        uint256 votesAgainst;
        bool isAuthentic;
        uint256 votingEndTime;
        bool is_voting_complete;
    }
    

    //DAO variable
    ALPDAO public alpDAO;

    // Mapping to store NFT information based on contract ID and NFT ID
    mapping(bytes32 => NFT) public nfts;


    // Constructor to set the reference to the ALPDAO contract we need to set ALPDAO contract address to run this
    constructor(address _alpDAOContractAddress) {
        alpDAO = ALPDAO(_alpDAOContractAddress);
    }

    // Function to check if caller is a member of the ALPDAO contract
    function isALPDAOMember() private view returns (bool) {
        return alpDAO.isMember(msg.sender);
    }

    
    // Function to enroll a new NFT
    function enrollNewNFT(address _contractAddress, uint256 _tokenId) public {
        bytes32 nftId = keccak256(abi.encodePacked(_contractAddress, _tokenId));
        
        // Ensure that NFT does not already exist
        require(nfts[nftId].contractAddress == address(0), "NFT already exists");
        
        // Set voting duration to 5 minutes
        uint256 votingDuration = 5 minutes;
        
        // Add NFT to mapping with default values
        nfts[nftId] = NFT({
            contractAddress: _contractAddress,
            tokenId: _tokenId,
            votesFor: 0,
            votesAgainst: 0,
            isAuthentic: false,
            votingEndTime: block.timestamp + votingDuration,
            is_voting_complete: false
        });
    }
    
    // Function to vote for or against an NFT
    function voteToNewNFT(address _contractAddress, uint256 _tokenId, bool _voteFor) public {
        bytes32 nftId = keccak256(abi.encodePacked(_contractAddress, _tokenId));
        
        // Ensure that NFT exists
        require(nfts[nftId].contractAddress != address(0), "NFT does not exist");

        // Ensure that caller is a member of the ALPDAO contract
        require(isALPDAOMember(), "You have no membership from ALPDAO to cast vote");
        
        // Ensure that voting period has not expired
        require(block.timestamp <= nfts[nftId].votingEndTime, "Voting period has expired");
        
        // Update vote count based on whether vote is for or against
        if (_voteFor) {
            nfts[nftId].votesFor += 1;
        } else {
            nfts[nftId].votesAgainst += 1;
        }
        
        // Check if voting period has expired
        if (block.timestamp > nfts[nftId].votingEndTime) {
            // Update isAuthentic attribute if votesFor are higher than votesAgainst
            if (nfts[nftId].votesFor > nfts[nftId].votesAgainst) {
                nfts[nftId].isAuthentic = true;
            }
        }
    }
    
     function decesionNFTAuthenticity(address _contractAddress, uint256 _tokenId) public returns(uint votesFor,uint votesAgainst, bool is_Authentic, bool is_voting_finnished, uint voting_endtime) {
     
      bytes32 nftId = keccak256(abi.encodePacked(_contractAddress, _tokenId));
        
        // Ensure that NFT exists
        require(nfts[nftId].contractAddress != address(0), "NFT does not exist");

         if(nfts[nftId].is_voting_complete==false)
         {
                if (block.timestamp > nfts[nftId].votingEndTime) {
                    // Update isAuthentic attribute if votesFor are higher than votesAgainst
                    if (nfts[nftId].votesFor > nfts[nftId].votesAgainst) {
                        nfts[nftId].isAuthentic = true;
                        nfts[nftId].is_voting_complete = true;
                    }
                }
         }

        return (nfts[nftId].votesFor,nfts[nftId].votesAgainst,nfts[nftId].isAuthentic,nfts[nftId].is_voting_complete,nfts[nftId].votingEndTime);    
     }
    


}
