//SPDX-License-Identifier:GPL-3.0

pragma solidity ^0.8.0;

contract UsageBasedInsurance {
    // Define the terms of the contract
    string public policyType;
    uint public policyDuration;
    uint public policyPremium;

    // Define the parties involved
    address public insurer;
    address public policyholder;

    // Define the constructor function
    constructor(string memory _policyType, uint _policyDuration, uint _policyPremium, address _insurer, address _policyholder) {
        policyType = _policyType;
        policyDuration = _policyDuration;
        policyPremium = _policyPremium;
        insurer = _insurer;
        policyholder = _policyholder;
    }

    // Define the function for calculating the premium
    function calculatePremium(uint _milesDriven) public view returns (uint) {
        return _milesDriven * policyPremium / policyDuration;
    }

    // Define the function for submitting a claim
    function submitClaim(uint _claimAmount) public {
        require(msg.sender == policyholder, "Only the policyholder can submit a claim");
        require(_claimAmount <= address(this).balance, "Insufficient funds to cover the claim");
        payable(policyholder).transfer(_claimAmount);
    }

    // Define the function for checking the policy status
    function checkPolicyStatus() public view returns (string memory, uint, uint) {
        return (policyType, policyDuration, policyPremium);
    }
}