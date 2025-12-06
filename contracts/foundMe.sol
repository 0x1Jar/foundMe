//Get funds from users
//withdraw funds
//Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {PriceConverter} from "./priceConverter.sol";

error NotOwner();

contract FoundMe {

    using PriceConverter for uint256;

    //use constant to save gas
    uint256 public constant MINIMUM_USD = 50 * 1e18; //1 * 10 ** 18

    address[] public  founders;
    mapping (address => uint256 amountFounded) public addressToAmountFounded;

    //imutable
    address public immutable i_owner;

    //special function
    constructor() {
        i_owner = msg.sender;
    }

    function funds( ) public payable {
        // msg.value.getConversionRate();
        require(msg.value.getConversionRate() >= MINIMUM_USD, "didn't send enough ETH");
        founders.push(msg.sender);
        addressToAmountFounded[msg.sender] += msg.value;
    }

    function withdraw() public {
        //for loop
        // for (/* start index, ending index,  step amount*/)
        for (uint256 founderIndex = 0 ; founderIndex < founders.length; founderIndex++){
            address funder = founders[founderIndex];
            addressToAmountFounded[funder] = 0;
        }
        //reset the aray
        founders = new address[](0);
        // actually withdraw the funds

        //call
        (bool callSuccess, ) = payable (msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "call failed");
        revert();  
    }

    modifier onlyOwner() {
        // require(msg.sender == i_owner, "Sender not owener!");
        if(msg.sender != i_owner) {revert NotOwner();} //gas eficiency
        _;
    }

    receive() external payable { 
        funds();
    }

    fallback() external payable {
        funds();
     }
}