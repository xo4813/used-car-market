pragma solidity ^0.4.26;

contract UsedCar{
	address public owner;

	uint requestPurchasesIndex;
	uint sellIndex;
	address[] requestPurchases;
	address[] underInspections;
	address[] selling;

	modifier onlyOwner(){
		require(msg.sender==owner);
		_;
	}

	function UsedCar(){
		owner=msg.sender;
	}

	function setOwner() onlyOwner{
		owner=msg.sender;
	}

	function requestPurchase(uint _VIN, uint _modelNo, string _carName, string _productYear, string _licenseNum ,
		string _fuel){
		DealearDealing d=new DealearDealing(_VIN, _modelNo, _carName, _productYear, _licenseNum, _fuel);
		requestPurchases.push(d);
	}

	function successPurchase(){
		if(msg.sender!=owner) return;


	}

	function startSell(uint _index){
		waiting[sellIndex]=buying[_index]; 
		delete waiting[_index];
		sellIndex=sellIndex+1;
	}

	function request

}