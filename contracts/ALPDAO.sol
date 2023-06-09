pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./ALPToken.sol";
//import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";


contract ALPDAO is Ownable {
    using SafeMath for uint256;

    event NewMember(address indexed memberAddress, string socialUrl);
    event ReputationUpdate(address indexed memberAddress, uint newReputation);
    event MemberApproved(address indexed memberAddress, bool isApproved);

    struct Member {
        address payable addr;
        string socialUrl;
        uint reputation;
        bool is_active;
        bool isSocialVerified;
        // other member must vote the user before he become active member
        uint votes_for;
        uint votes_against;
        uint voting_period_time;
        bool isVoterRejected;
    }

    // votes against record
    mapping (address => mapping (address => bool)) private votes;

    uint private registrationFee = 0.01 ether; //GWEI 10000000
    uint private voting_time_duration = 1 minutes; //so we can test in 1 minutes in this prototype

    ALTP public altpToken;

    mapping(address => Member) public members;
    address[] private memberList;
 


    /*

    THESE SHALL BE THE ORACLE VARIABLES (DUE TO TIME CONSTRAINTS I AM NOT USING THEM FOR THE OPTIC TEST) BUT LIVING AS A CODE SNIPPET
    address private oracle;
    bytes32 private jobId;
    uint256 private fee;

    */


    //initialize the special first members 
    constructor(string memory _firstMbrSocialUrl) payable {

        // the first user must also pay the fees to register this contract
        require(msg.value == registrationFee, "Registration fee must be 0.01 ETH or  10000000 GWEI");

        //create a simple supply of token for initial supply
        altpToken = new ALTP(1000);

        // The first member must share his socialmedia account and he doesnt need votes since he is the first one        
        members[msg.sender] = Member(payable(msg.sender), _firstMbrSocialUrl, 12, true,true,1,0,block.timestamp,false);
        //transfer 100 altp tokens
         altpToken.transfer(msg.sender, 100);
    }

    function registerMe(string memory _socialUrl) public payable {
        require(msg.value == registrationFee, "Registration fee must be 0.01 ETH or  10000000 GWEI");
        require(members[msg.sender].addr == address(0), "Member already registered");
        
        // by default we are verifying social account as true , we are allowing voting time for 5 minutes
        members[msg.sender] = Member(payable(msg.sender), _socialUrl, 12, false,true,0,0, block.timestamp + voting_time_duration,false);
        memberList.push(msg.sender);
        
     // Initiate Chainlink request to verify social media URL
     //   requestId = requestRandomness(jobId, fee);
     //   verificationPending = true;
     //   emit SocialUrlVerificationRequested(requestId, msg.sender, _socialUrl);

        emit NewMember(msg.sender, _socialUrl);
    }

    // the address must be provided who needs voting in his favor or against
    function voteThisMember(address _member, bool _in_favor) public {
        require(members[_member].is_active == false, "The member you are trying to vote for is already active");
        require(members[msg.sender].is_active == true, "You are not a registered member make sure your voting is done to get active.");
        require(votes[msg.sender][_member] == false, "You have already voted for this member.");
        require(block.timestamp < members[_member].voting_period_time, "The voting period has elapsed.");

        votes[msg.sender][_member] = true;
        
        if (_in_favor) {
            members[_member].votes_for++;
        } else {
            members[_member].votes_against++;
        }
        
      //  emit NewVote(msg.sender, _member, _in_favor);
    }
    

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");

        altpToken.transfer(msg.sender, msg.value);
     //   emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public onlyOwner {
        require(address(this).balance >= amount, "Insufficient balance");

        payable(msg.sender).transfer(amount);
    }

   

    function getTotalVotes(address adr) public view returns(uint voteFor,uint votAgainst) {

       return (members[adr].votes_for,members[adr].votes_against);
    }

    //ideally we will use this function through time event or oracle
    function activateMyMembership() public payable returns(uint voteFor,uint votAgainst, uint curtime,uint votetime) {

        require(members[msg.sender].isVoterRejected == false, "You are rejected by the other Members of DAO");

        //lets activate the user if voting time is done. (Currently just for the prototype lets activate by self otherwise he wouldnt vote)
        if(block.timestamp > members[msg.sender].voting_period_time && members[msg.sender].is_active ==false) {
            
            //check if members rejected his registration 
            if(members[msg.sender].votes_against>members[msg.sender].votes_for)
            {
                members[msg.sender].isVoterRejected = true;
                // transfer the deposit fees back to the user
                payable(msg.sender).transfer(registrationFee);
            }
            else
            {
                //transfer ALPT token which he can use later for the voting assets
                altpToken.transfer(msg.sender, 100);
                members[msg.sender].is_active = true;
            }

        } 

       return (members[msg.sender].votes_for,members[msg.sender].votes_against,block.timestamp,members[msg.sender].voting_period_time);
    }

    function getMyMemberDetails() public view returns (Member memory member) {

        return members[msg.sender];
    }

    function isMember(address memAdr) external view returns (bool isMember) {

            return members[msg.sender].is_active;
    }

    function totalALPTokens() view public returns(uint256 ret) {
        return altpToken.getUserBalance(msg.sender);
    }

    function depositALPTokenForAssetVoting() view public returns(uint256 ret) {
        return altpToken.getUserBalance(msg.sender);
    }



/*
    function verifySocialMediaAddress(string memory _addressString) private {
        require(!verificationPending, "Verification already in progress");
        
        // ORACLE CALL TO VERIFY SOCIAL MEDIA ACCOUNT (I AM COMMENTING THIS PART, JUST TO SHOW AS A SAMPLE HOW VERIFICATION SHOULD BE DONE)

        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfillAddressVerification.selector);
        request.add("get", string(abi.encodePacked("https://api.chain.link/v1/vrf/randomness?min=0&max=1")));
        request.add("path", "result");
        requestId = sendChainlinkRequestTo(oracle, request, fee);
        
        members[msg.sender].isVerified = false;
        verificationPending = true;
    }
*/
    
}