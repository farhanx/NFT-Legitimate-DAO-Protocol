# NFT Legitimate DAO Protocol
This is a legitimate DAO protocol for NFTs or assets. The protocol has been developed entirely from scratch to address the existing issues regarding the vast sea of NFTs where the value is somewhat blurred. 

**Problem in the Decentralized World :** 
----------------------------------------------
In the realm of digital environments, assessing the authenticity and acceptability of an asset within a thriving and expansive community proves to be a challenging task, even with comprehensive information at hand. In fact, accomplishing this task becomes nearly unattainable in the absence of such information.

**Solution is DAO Decentralized Autonomous Organization Protocol:**
 ----------------------------------------------

1) Implementation of a protocol that engages an open community can address the challenges of evaluating asset quality in a digital environment.
2) The protocol establishes a trustworthy and reliable mechanism for determining the acceptability of public assets.
3) The evaluation process is driven by a community with distributed voting power.
4) An adaptive identity validation process ensures effective oversight and moderation.
5) This approach offers a scalable solution to content moderation as the digital asset landscape expands and evolves.
6) The involvement of a self-regulated community plays a crucial role in resolving the problem.
7) The community actively decides on membership, including adding or removing individuals.
8) Consensus is reached within the community through voting to evaluate asset authenticity.
9) Each community member has the opportunity to vote on the legitimacy of an asset.

## ** Protocol Framework **
----------------------------------------------------------

![](tech-framework.png)

## ** Protocol Architecture **
----------------------------------------------------------
![](architecture.png)


##  Protocol Details! 
----------------------------------------------------------

We named our protocol “Asset Legit protocol”. In order to achieve this protocol following needs to be addressed. 

**1. DAO Creation**

 1.1) A DAO must be created by the community renowned members like Ethereum Foundation, OpenSea, and others. 

 1.2) Each Chain must represent its own DAO Creation with respect to a Smart Contract. 
 
 1.3) For instance, Ethereum based contract will cover only Ethereum based assets. (Currently we chose Ethereum)

**2. Asset Legit Protocol ALPT Token**

 2.1) The ALPT token will be created to incentivize the members.

 2.2) A separate smart contract must be created with lazy minting.

 2.3) These tokens should be allowed to trade as an asset.


**3. Members Registration and Verification:**
  
 3.1) To register, a user needs to deposit a membership fee.

 3.2) Additionally, every user must declare their social identity.

 3.3) The new joiner must call a verification transaction to DAO with Fee

 3.4) Joiner shares his social media post with his EOA address.  

 3.5) The DAO contract will call Chainlink oracle to verify EOA Address

 3.6) If the Post address matches the joiner’s address he is in. 

 3.7) Last part is voting by DAO members on the arrival of a new member.

 3.8) Higher votes allowed the new user to become DAO member.

 3.9) New joiners will get an initial reputation of 12 points.  

 3.10) New joiner will get ALPT Tokens against his paid Fees.

**4. Asset Enrollment:**

 4.1) A separate contract must be used for this purpose. 

 4.2) Anyone can submit an Asset for its audit. 

 4.3) Asset ID and Contract address must be provided for evaluation.

**5. Asset Voting Consensus :**

 5.1) The DAO Members can only vote for the asset, not anyone else.

 5.2) Every member must deposit ALPT tokens to vote for any new asset.

 5.3) Every Vote will be weighted with respect to the voter’s reputation.

 5.4) Voting only targets if the asset “is fake” or “is authentic”.

 5.5) Voting should have the criteria of time limit for each asset

 5.6) Members with the higher votes on the “is fake” or “is authentic” will get 
    
    5.6.1).  Reputation points 
   
    5.6.2).  ALPT tokens as incentives 

**6. Reputation Management:**

 6.1) Every DAO Member’s reputation will get increased by voting.

 6.2) Reputation points will increase based on his current reputation weight.

 6.3) Every month, 2% of each member’s reputation will decrease.

**7. Asset or Member Dispute Management:  **

 7.1) Any public user can initiate a dispute on the Asset by paying a fee.

 7.2) New disputes can create new voting by DAO Members

 7.3) DAO Members can initiate votes against each other to remove bad actors

 7.4) Reputation will get effected on bad vote and choices 

## **Further Optimization Requirement **

![](optimizations.png)

## **Contracts **
There are three contracts created in the contract directory.

 1) ALPDAO.SOL
    
 3) ALPTOKEN.SOL
    
 4) NFTEVAL.SOL

 ## **Disclaimer **

If you are interested in utilizing this DAO protocol, please contact me for a comprehensive understanding and access to the complete code. This protocol represents a new innovation, and I am more than willing to provide further details. However, please note that while the uploaded code and framework are freely available for use, it is essential to thoroughly review and assess them to ensure their suitability for your specific needs. I cannot be held responsible for any potential consequences or damages arising from the use of this protocol. Kindly exercise due diligence and consult with appropriate experts before implementing it in any environment. ( Farhan Khan)
