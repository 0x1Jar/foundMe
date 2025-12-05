//Get funds from users
//withdraw funds
//Set a minimum funding value in USD

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract FoundMe {

    uint256 public minumumUsd = 5e18;
    address[] public  founders;
    mapping (address => uint256 amountFounded) public addressToAmountFounded;

    function funds( ) public payable {
        //allow users to send $
        // Have a minimum $ to sent $5
        //. 1. How do we send ETH to this contract?

        require(getConversionRate(msg.value) >= minumumUsd, "didn't send enough ETH"); // 1e18 = 1 ETH =  1000000000000000000 = 1 * 10 ** 18
    }
    // What is a reverst?
    // Undo any actions that have been done, and send the remining gas back

    // function withdraw() public {}

    function getPrice () public view returns (uint256) {
        //address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        //ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 price, , ,) = priceFeed.latestRoundData();

        return uint256 (price * 1e10);
    }
    function getConversionRate (uint256 ethAmount) public view returns (uint256) {
        //1 ETH?
        //2000_00000000000000000
        uint256 ethPrice = getPrice();
        //(2000_00000000000000000 * 1_00000000000000000 / 1e10;
        //2000$ = 1 ETH
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e10;
        return ethAmountInUsd;
    }

    function getVersion() public view returns (uint256){
        return AggregatorV3Interface (0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}