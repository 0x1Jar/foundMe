//Get funds from users
//withdraw funds
//Set a minimum funding value in USD
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {PriceConverter} from "priceConverter.sol";

contract FoundMe {

    using PriceConverter for uint256;

    uint256 public minumumUsd = 5e18;

    address[] public  founders;
    mapping (address => uint256 amountFounded) public addressToAmountFounded;

    function funds( ) public payable {
        // msg.value.getConversionRate();
        require(msg.value.getConversionRate() >= minumumUsd, "didn't send enough ETH"); //1e18
        founders.push(msg.sender);
        addressToAmountFounded[msg.sender] = addressToAmountFounded[msg.sender] + msg.value;

    }
    // What is a reverst?
    // Undo any actions that have been done, and send the remining gas back

    // function withdraw() public {} 
}