// SPDX-License-Identifier: UNLICENSED

// Connect your local environment to Solidity
//Step 1: In terminal type "remixd -s ."
//Step 2: Go to remix.ethereum.org and connect to local host
//Step 3: Add .gitignore file and add /artifacts/ (You will only see artifacts after your deploy)
//Step 4: You can commit your changes on github

pragma solidity >=0.7.0 <0.9.0;

contract MyToken {

    // We need to keep track of every address's balance

    // Keep track of minter
    address public minter;

    //Query or modify the balance of any address who participated with our smart contract
    mapping (address => uint) public balances;

    //Events are a way people can subscribe and react to changes in our contract
    event Sent(address from, address to, uint amount);

    constructor() {
        //        refers to the person who made the contract
        minter = msg.sender;
    }
    // Function that mints the token
    function mint(address receiver, uint amount ) public {
        // Only the minter can mint the token
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    function send(address receiver, uint amount) public {
        // Check if they sufficient funds to send that amount
        require(amount <= balances[msg.sender], "Insufficient Balance");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }

    
}