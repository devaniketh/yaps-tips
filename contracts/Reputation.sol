// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Reputation {
    mapping(address => uint256) public reputationScores;

    event ReputationUpdated(address yapper, uint256 newScore);

    function updateReputation(address yapper, uint256 score) external {
        reputationScores[yapper] = score;
        emit ReputationUpdated(yapper, score);
    }

    function getReputation(address yapper) external view returns (uint256) {
        return reputationScores[yapper];
    }
}