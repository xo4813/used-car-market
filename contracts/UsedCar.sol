pragma solidity ^0.4.26;
import "./DealearDealing.sol";

contract UsedCar{
	address public owner;
	string public agentBoss;
	string public agentNo;

	uint usedCarNum;
	uint completionNum;
	address[] usedCars;
	address[] completion;
	mapping(address => car) usedCarsInfo;
	mapping(address => car) completionInfo;

	//기업 설정
	struct car{
		bool isReg;
		uint index;
	}

	modifier onlyOwner(){
		require(msg.sender==owner);
		_;
	}

	function UsedCar(){
		owner=msg.sender;
		agentBoss="Seok Hyeon Yoon";
		agentNo="123456-01-123456";
		usedCarNum=0;
		completionSum=0;
	}

	function setOwner() onlyOwner{
		owner=msg.sender;
	}

	function setAgent(string _boss, string _no) onlyOwner{
		agentBoss=_boss;
		agentNo=_no;
	}

	function addDealing(){
		DealearDealing d=new DealearDealing(owner, agentBoss, agentNo);
		usedCars.push(address(d));
		usedCarsInfo[address(d)].isReg=true;
		usedCarsInfo[address(d)].index=usedCarNum;
		usedCarNum+=1;
	}

	function successSell(){
		completionNum
	}
	
}