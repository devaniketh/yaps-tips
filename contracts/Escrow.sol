// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Escrow {
    struct Yap {
        address user;
        uint256 amount;
        bool isCompleted;
    }

    mapping(uint256 => Yap) public yaps;

    event YapCreated(uint256 yapId, address user, uint256 amount);
    event YapCompleted(uint256 yapId, address yapper);

    function deposit(uint256 yapId) external payable {
        require(yaps[yapId].user == address(0), "Yap ID already exists");

        yaps[yapId] = Yap({
            user: msg.sender,
            amount: msg.value, // Use msg.value directly
            isCompleted: false
        });

        emit YapCreated(yapId, msg.sender, msg.value);
    }

    function release(uint256 yapId, address yapper) external {
        require(!yaps[yapId].isCompleted, "Yap already completed");

        yaps[yapId].isCompleted = true;
        payable(yapper).transfer(yaps[yapId].amount);

        emit YapCompleted(yapId, yapper);
    }
}
