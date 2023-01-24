// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.9;

contract VendingMachine {

    enum Product { ICE_TEA, MARS, LION, FANTA, COCA_COLA }

    mapping(Product => uint) public prices;
    mapping(Product => uint) public stock;
    mapping(address => uint) public balances;
    address owner;
    uint public maxStock;

    constructor() {
        prices[Product.ICE_TEA] = 100;
        prices[Product.MARS] = 150;
        prices[Product.LION] = 200;
        prices[Product.FANTA] = 125;
        prices[Product.COCA_COLA] = 175;
        
        stock[Product.ICE_TEA] = 10;
        stock[Product.MARS] = 15;
        stock[Product.LION] = 20;
        stock[Product.FANTA] = 15;
        stock[Product.COCA_COLA] = 20;
        
        owner = msg.sender;
        maxStock = 50;
    }

    function buyProduct(Product product) public payable {
        require(prices[product] <= msg.value, "Insufficient funds");
        require(stock[product] > 0, "Out of stock");

        stock[product] -= 1;
        balances[msg.sender] += msg.value;
    }

     modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
    
    function reloadProduct(Product product, uint amount) public onlyOwner {
        require(amount > 0 && amount <= maxStock - stock[product], "Invalid amount");
        stock[product] += amount;
    }
    
}
