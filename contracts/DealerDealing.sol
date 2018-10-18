pragma solidity ^0.4.26;

contract DealerDealing{

	contractingParites seller;
    contractingParites buyer;

	//매매업자 정보
	address agentAddr;
	string agentBoss;
	string agentNo;
	address transactorAddr;
    string transactorName;

    //거래내역 정보
    string date;
    uint amount;
    string depositDate;
    uint deposit;
    string middleDate;
    uint middlePayment;
    string balanceDate;
    uint balance;
    string deliveryDate;

    //차 내용
    uint VIN;
    uint modelNo;
    string carName;
	string productYear;
	string licenseNum;
	string fuel;

	//중고차 성능점검
	address inspectionRecord;
	uint inspectionCost;
	uint estimateValue;
	uint repairCost;


    struct contractingParites{ 
        address addr;
        string name;
        string phoneNum;
        string residenceAddress;
    }
   
	function DealerDealing(address _transactorAddr, string _transactorName, uint _VIN, uint _modelNo, string _carName,
		string _productYear, string _licenseNum, string _fuel){
		transactorAddr=_transactorAddr;
		transactorName=_transactorName;
		VIN=_VIN;
		modelNo=_modelNo;
		carName=_carName;
		productYear=_productYear;
		licenseNum=_licenseNum;
		fuel=_fuel;
	}

	function setEstimateValue(uint _estimateValue){
		estimateValue=_estimateValue;
	}

	function setRefairCost(uint _repairCost){
		repairCost=_repairCost;
	}

	function sellerApprove(){

	}

	function agentApprove(){
		
	}

	function buyerApprove(){
		
	}

	


}
