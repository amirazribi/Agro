// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract AnalysisContract {
    address public owner;

    struct AnalysisResult {
        string result;
    }

    AnalysisResult[] public analysisResults;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function saveAnalysisResult(string memory _result) public {
        AnalysisResult memory newResult = AnalysisResult({
        result: _result
        });
        analysisResults.push(newResult);
    }

    function getAnalysisResultsCount() public view returns (uint) {
        return analysisResults.length;
    }

    function getAnalysisResult(uint index) public view returns (string memory) {
        require(index < analysisResults.length, "Invalid index");
        AnalysisResult memory result = analysisResults[index];
        return result.result;
    }
}
