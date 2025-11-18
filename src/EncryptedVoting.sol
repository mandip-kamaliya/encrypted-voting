// SPDX-License-Identifier: MIT

pragma solidity ^0.8.25;

import "@fhenixprotocol/cofhe-contracts/FHE.sol"

type euint8 is uint256;
contract EncryptedVoting{
    euint8 public encryptedtally;

    address public immutable i_owner;

    bool public decriptrequested;

    euint8 public ENCRYPTED_ZERO;

    event VoteCast(address indexed voter);


}