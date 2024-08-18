//SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract StartStopUpdateExample {

    // This contract is a simple example of a smart contract with the following functionalities:

    // Allows the owner to pause or unpause the contract.
    // Allows the owner to withdraw all funds from the contract to a specified address, 
    // but only if the contract is not paused.
    // Allows the owner to destroy the contract and send any remaining balance to a specified address.

    address public owner; // Stores the address of the contract owner
    bool public paused; // A boolean variable that indicates whether the contract is paused or not

    // A global variable that holds the address of the caller (in this case, the person deploying 
    // the contract). The owner of the contract (owner) is set to the address of the person deploying it.

    constructor() {
        owner = msg.sender;
    }

    // This function allows the contract to receive money (ether). The payable keyword indicates 
    // that the function can accept ether. However, the function does not perform any action other 
    // than allowing the contract to receive funds

    function sendMoney() public payable {

    }

    // This function allows the contract owner to pause or unpause the contract.
    // require(msg.sender == owner, "You are not the owner"): Ensures that only the contract 
    // owner can pause or unpause the contract. If someone other than the owner tries to call this 
    // function, the execution will stop, and an error message will be shown.
    // paused = _paused: Sets the state of the contract (paused or not) according to the 
    // boolean value _paused passed as an argument.

    function setPaused(bool _paused) public {
        require(msg.sender == owner, "You are not the owner");
        paused = _paused;
    }

    // This function allows the contract owner to withdraw all funds stored in the contract and send 
    // them to a specified address (_to).
    // require(owner == msg.sender, "You cannot withdraw."): Ensures that only the owner can 
    // withdraw the funds.
    // require(paused == false, "Contract Paused"): Ensures that the contract is not paused. 
    // If it is paused, the withdrawal cannot proceed.
    // _to.transfer(address(this).balance): Transfers the entire balance of the contract to 
    // the _to address.

    function withdrawAllMoney(address payable _to) public {
        require(owner == msg.sender, "You cannot withdraw.");
        require(paused == false, "Contract Paused");
        _to.transfer(address(this).balance);
    }

    // This function allows the contract owner to destroy the contract.
    // require(msg.sender == owner, "You are not the owner"): Ensures that only the owner can 
    // destroy the contract.
    // selfdestruct(_to): Destroys the contract and sends any remaining balance to the _to address.

    function destroySmartContract(address payable _to) public {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(_to);
    }
}