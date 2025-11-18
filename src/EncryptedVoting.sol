// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import "@fhenixprotocol/cofhe-contracts/FHE.sol";

//type euint8 is uint256;
contract EncryptedVoting {
    euint8 public encryptedtally;

    address public immutable i_owner;

    bool public decriptRequested = false;

    euint8 private ENCRYPTED_ZERO;

    event VoteCast(address indexed voter);

    constructor() {
        i_owner = msg.sender;

        ENCRYPTED_ZERO = FHE.asEuint8(0);
        FHE.allowThis(ENCRYPTED_ZERO);
        encryptedtally = ENCRYPTED_ZERO;
        FHE.allowThis(encryptedtally);
    }

    function castVote(InEuint8 calldata encryptedVote) public {
        euint8 vote = FHE.asEuint8(encryptedVote);
        encryptedtally = FHE.add(encryptedtally, vote);
        FHE.allowThis(encryptedtally);
        emit VoteCast(msg.sender);
    }

    function decryptRequested() external {
        require(msg.sender == i_owner, "only owner a owner can call this");
        require(!decriptRequested, "Decryption already requested");
        FHE.allowSender(encryptedtally);
        FHE.decrypt(encryptedtally);
        decriptRequested = true;
    }

    function getFinalTally() external view returns (uint8 _tally) {
        require(msg.sender == i_owner, "Only owner can view tally");
        require(decriptRequested, "Decryption not requested");

        (uint8 finalTally, bool isReady) = FHE.getDecryptResultSafe(encryptedtally);

        require(isReady, "Decryption not yet complete. Try again shortly.");

        return finalTally;
    }

    function getEncryptedTally() external view returns (euint8) {
        return encryptedtally;
    }
}
