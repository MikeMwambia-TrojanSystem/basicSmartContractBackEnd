// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "hardhat/console.sol";


contract WavePortal {

    uint256 totalWaves;

    //Map of the addresses waving
    mapping(address => uint) public numberofWaves;

    /**
    We will use this to generate random number
     */
    uint256 private seed;

    //Add event to emit a new wave
    event NewWave(address indexed from,uint256 timestamp,string message);

    //Create a struct to store custom data
    struct Wave {
        address waver;//The address of the person waving
        string message;//Message sent with a wave
        uint256 timestamp;//Time when the wave happened
    }

    //This stores an array of waves
    Wave[]waves;

    //Maps waving address to last time waved
    mapping(address => uint256) public lastWavedAt;

    constructor() payable { 
        console.log("Yo yo,I am a contract and I am smart");
        /**
        Set the initial seed
         */
        seed = (block.difficulty + block.timestamp) % 100;

    }

    //Public can be called by anyone
    function wave(string memory _message) public {

        /**
        Ensure the current timestamp is at least 15 minutes bigger.
        Cool down mechanism
         */

        require(lastWavedAt[msg.sender] + 15 minutes < block.timestamp,"Wait 15 minutes untill you wave again");

        /**
        Update current timestamp we have for the user
        */
        lastWavedAt[msg.sender] = block.timestamp;


        totalWaves +=1;

        numberofWaves[msg.sender] +=1;

        console.log("%s has waved!",msg.sender);

        waves.push(Wave(msg.sender,_message,block.timestamp));

        uint256 prizeAmount = 0.0001 ether;

        //Generate new seed 
        seed = (block.difficulty + block.timestamp + seed) % 100;

        //Give 50% chance
        if(seed <= 17){

        console.log("%s won!",msg.sender);
                  
        require(prizeAmount <= address(this).balance,
        "Trying to withdraw more money that the contract has.");

        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");

        }

        //Emit an event of an added wave
        emit NewWave(msg.sender, block.timestamp,_message);

    }

    //Pay attention to the return 
    function getTotalWaves() public view returns (uint256){

        console.log("We have %d total waves!",totalWaves);

        console.log('Your connected address');

        console.log("For your address we have %n",numberofWaves[msg.sender]);

        return totalWaves;
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }


}