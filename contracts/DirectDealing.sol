pragma solidity ^0.4.26;

/**
 * The DirectDealing
  contract does this and that...
 */
contract DirectDealing{
	contractingParites seller;
    contractingParites buyer;

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

	function DirectDealing(){
		
	}
}


