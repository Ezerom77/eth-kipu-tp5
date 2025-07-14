// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

/// @title Interface to interact with the Grader5 contract
/// @notice Defines the necessary functions to interact with the Grader5 contract
/// @dev This interface includes only the functions we need to call from the Grader5 contract
interface IGrader5 {
    /// @notice Function to send weis and receive 1 wei back
    /// @dev Increments an internal counter for the calling address
    function retrieve() external payable;

    /// @notice Function to register a student name and assign a grade
    /// @dev Requires that the counter of the calling address is greater than 1
    /// @param name Name of the student to register
    function gradeMe(string calldata name) external;

    /// @notice Function to query the counter value of an address
    /// @dev Returns the current counter value for the specified address
    /// @param addr Address for which to query the counter
    /// @return Current counter value for the specified address
    function counter(address addr) external view returns (uint256);
}

/// @title Contract to interact with Grader5
/// @notice This contract allows interaction with the Grader5 contract to register the name "Ezerom77"
/// @dev Implements a mechanism to call retrieve() twice and then gradeMe()
/// @author Ezerom77
contract Ezerom77 {
    /// @notice Reference to the Grader5 contract
    /// @dev Initialized in the constructor with the address of the Grader5 contract
    IGrader5 public graderContract;

    /// @notice Indicates if we are in the process of calling retrieve
    /// @dev Used to control the flow in the receive function
    bool private retrieving = false;

    /// @notice Contract constructor
    /// @dev Initializes the reference to the Grader5 contract
    /// @param _graderAddress Address of the deployed Grader5 contract
    constructor(address _graderAddress) {
        graderContract = IGrader5(_graderAddress);
    }

    /// @notice Initiates the retrieve calls process
    /// @dev Calls retrieve once and configures the state so that receive calls retrieve again
    /// @dev Requires that more than 3 weis are sent with the transaction
    function startRetrieve() external payable {
        require(msg.value > 3, "Wies>3_needed");
        retrieving = true;
        graderContract.retrieve{value: 4}();
    }

    /// @notice Calls the gradeMe function with the parameter "Ezerom77"
    /// @dev Should be called after the counter is greater than 1
    /// @dev It is recommended to verify the counter before calling this function
    function callGradeMe() external {
        graderContract.gradeMe("Ezerom77");
    }

    /// @notice Function to receive ether
    /// @dev Activated when the contract receives ether
    /// @dev If we are in the process of retrieving and receive 1 wei (from Grader5), we call retrieve again
    receive() external payable {
        if (retrieving && msg.value == 1) {
            retrieving = false; // Avoid an infinite loop
            if (address(this).balance >= 4) {
                graderContract.retrieve{value: 4}();
            }
        }
    }
}
