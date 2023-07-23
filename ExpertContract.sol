// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ExpertContract {
    address public owner;
    uint public temperature;
    uint public soilHumidity;
    uint public airHumidity;

    event PhotoAnalyzed(uint indexed itemId, string itemName, bool isInfected);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    struct Photo {
        uint id;
        string itemName;
        bool isInfected;
    }

    Photo[] public photos;

    function analyzePhoto(uint _itemId, string memory _name, bool _isInfected) public onlyOwner {
        photos.push(Photo(_itemId, _name, _isInfected));
        emit PhotoAnalyzed(_itemId, _name, _isInfected);
    }

    function setTemperature(uint _temperature) public onlyOwner {
        temperature = _temperature;
    }

    function setSoilHumidity(uint _soilHumidity) public onlyOwner {
        soilHumidity = _soilHumidity;
    }

    function setAirHumidity(uint _airHumidity) public onlyOwner {
        airHumidity = _airHumidity;
    }

    function getTemperature() public view returns (uint) {
        return temperature;
    }

    function getSoilHumidity() public view returns (uint) {
        return soilHumidity;
    }

    function getAirHumidity() public view returns (uint) {
        return airHumidity;
    }
}
