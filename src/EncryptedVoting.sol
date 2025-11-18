// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import "@fhenixprotocol/cofhe-contracts/FHE.sol";

//type euint8 is uint256;
contract EncryptedVoting{
    euint8 public encryptedtally;

    address public immutable i_owner;

    bool public decriptRequested=false;

    euint8 private ENCRYPTED_ZERO;

    event VoteCast(address indexed voter);
    
    constructor() {
        i_owner = msg.sender;

        ENCRYPTED_ZERO = FHE.asEuint8(0);
        FHE.allowThis(ENCRYPTED_ZERO);
        encryptedtally=ENCRYPTED_ZERO;
        FHE.allowThis(encryptedtally);

    }

    function castVote(InEuint8 calldata encryptedVote) public{
       euint8 vote = FHE.asEuint8(encryptedVote);
       encryptedtally = FHE.add(encryptedtally,vote);
       FHE.allowThis(encryptedtally);
       emit VoteCast(msg.sender);
    }

}