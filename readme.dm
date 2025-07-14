# Module 5 Practical Assignment - Ezerom77 Contract

## Description

This repository contains the `Ezerom77.sol` contract developed as a submission for the Module 5 Practical Assignment. The contract is designed to interact with an evaluator contract called `Grader5` through a defined interface.

- contract address:

## Functionality

The `Ezerom77` contract implements a mechanism to interact with the `Grader5` contract with the objective of registering the name "Ezerom77". To achieve this, the contract must:

1. Call the `retrieve()` function of the `Grader5` contract at least twice
2. Then call the `gradeMe()` function with the parameter "Ezerom77"

## Contract Structure

### IGrader5 Interface

Defines the necessary functions to interact with the `Grader5` contract:

- `retrieve()`: Function to send weis and receive 1 wei back. Increments an internal counter for the calling address.
- `gradeMe(string calldata name)`: Function to register a student name and assign a grade. Requires that the counter of the calling address is greater than 1.
- `counter(address addr)`: Function to query the counter value of an address.

### Ezerom77 Contract

Implements the logic to interact with the `Grader5` contract:

- `constructor(address _graderAddress)`: Initializes the reference to the `Grader5` contract.
- `startRetrieve()`: Initiates the process of calls to `retrieve()`. Requires that more than 8 weis are sent with the transaction.
- `callGradeMe()`: Calls the `gradeMe()` function with the parameter "Ezerom77".
- `receive()`: Function to receive ether. If we are in the process of retrieving and receive 1 wei (from `Grader5`), we call `retrieve()` again.

## How to Use

1. Deploy the `Ezerom77` contract providing the address of the `Grader5` contract as a constructor parameter.
2. Call the `startRetrieve()` function sending more than 3 weis. This will initiate the process of calls to `retrieve()`.
3. Once the counter is greater than 1, call the `callGradeMe()` function to register the name "Ezerom77".

## Author

- Ezerom77

