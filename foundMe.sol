//Get funds from users
//withdraw funds
//Set a minimum funding value in USD


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;


contract FoundMe {

    uint256 public myValue = 1;

    function funds( ) public payable {
        //allow users to send $
        // Have a minimum $ to sent
        //. 1. How do we send ETH to this contract?

        myValue = myValue + 2;
        require(msg.value > 1e18, "didn't send enough ETH"); // 1e18 = 1 ETH =  1000000000000000000 = 1 * 10 ** 18
    }

    // What is a reverst?
    // Undo any actions that have been done, and send the remining gas back



    // function withdraw() public {}
}