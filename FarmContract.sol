// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract FarmContract {
    address public owner;
    mapping(address => bool) public authorizedWholesalers;
    bool public isWateringEnabled;

    event ItemHarvested(uint indexed itemId, string itemName, uint quantity);
    event OrderAccepted(uint indexed orderId, address indexed client, string itemName, uint quantity);
    event OrderRejected(uint indexed orderId, address indexed client, string itemName, uint quantity);
    event FertilizerOrdered(uint indexed orderId, address indexed wholesaler, string itemName, uint quantity);

    constructor() {
        owner = msg.sender;
        isWateringEnabled = true;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    modifier onlyAuthorizedWholesaler() {
        require(authorizedWholesalers[msg.sender], "Only authorized wholesalers can call this function");
        _;
    }

    struct Item {
        uint id;
        string name;
        uint quantity;
    }

    Item[] public items;

    struct Order {
        uint id;
        address client;
        string itemName;
        uint quantity;
        bool isAccepted;
    }

    Order[] public orders;
    uint public currentOrderId = 1;

    function harvestItem(string memory _name, uint _quantity) public onlyOwner {
        uint itemId = items.length + 1;
        items.push(Item(itemId, _name, _quantity));
        emit ItemHarvested(itemId, _name, _quantity);
    }

    function authorizeWholesaler(address _wholesaler) public onlyOwner {
        authorizedWholesalers[_wholesaler] = true;
    }

    function toggleWatering() public onlyOwner {
        isWateringEnabled = !isWateringEnabled;
    }

    function acceptOrder(uint _orderId) public onlyOwner {
        Order storage order = orders[_orderId - 1];
        require(!order.isAccepted, "Order is already accepted");

        order.isAccepted = true;
        emit OrderAccepted(_orderId, order.client, order.itemName, order.quantity);
    }

    function rejectOrder(uint _orderId) public onlyOwner {
        Order storage order = orders[_orderId - 1];
        require(!order.isAccepted, "Order is already accepted");

        order.isAccepted = false;
        emit OrderRejected(_orderId, order.client, order.itemName, order.quantity);
    }

    function orderFertilizer(string memory _itemName, uint _quantity) public onlyOwner {
        uint orderId = currentOrderId;
        currentOrderId++;

        emit FertilizerOrdered(orderId, msg.sender, _itemName, _quantity);
    }
}