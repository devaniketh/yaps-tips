// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;


pragma solidity ^0.8.0;

contract Escrow {
    struct Yap {
        address user;
        uint256 amount;
        bool isCompleted;
    }

    mapping(uint256 => Yap) public yaps;
    uint256 public yapCounter;

    event YapCreated(uint256 yapId, address user, uint256 amount);
    event YapCompleted(uint256 yapId, address yapper);

    function deposit(uint256 yapId, uint256 amount) external payable {
        require(msg.value == amount, "Incorrect amount sent");
        yaps[yapCounter] = Yap({
            user: msg.sender,
            amount: amount,
            isCompleted: false
        });
        emit YapCreated(yapCounter, msg.sender, amount);
        yapCounter++;
    }

    function release(uint256 yapId, address yapper) external {
        require(!yaps[yapId].isCompleted, "Yap already completed");
        yaps[yapId].isCompleted = true;
        payable(yapper).transfer(yaps[yapId].amount);
        emit YapCompleted(yapId, yapper);
    }
}