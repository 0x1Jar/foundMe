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

    function callMeRightAway() public {
        
    }

    function funds( ) public payable {
        // msg.value.getConversionRate();
        require(msg.value.getConversionRate() >= minumumUsd, "didn't send enough ETH"); //1e18
        founders.push(msg.sender);
        addressToAmountFounded[msg.sender] += msg.value;

    }

    function withdraw() public {
        //for loop
        //[1, 2, 3,] elements 
        //0, 1, 2, 3 indexes
        // for (/* start index, ending index,  step amount*/)
        for (uint256 founderIndex = 0 ; founderIndex < founders.length; founderIndex++){
            address funder = founders[founderIndex];
            addressToAmountFounded[funder] = 0;
        }
        //reset the aray
        founders = new address[](0);
        // actually withdraw the funds

        //not recomeded using trasnfer and send!
        //transfer
        // payable(msg.sender).transfer(address(this).balance);
        // //send
        // bool sendSuccess = payable (msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send Failed");
        //call
        (bool callSuccess, ) = payable (msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "call failed");
        
    } 
}