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

    uint estimateValue;
    //중고차 성능점검
    address inspectionRecord;
    uint inspectionCost;
    address repairEstimate;
    uint repairCost; 

    struct contractingParites{ 
        address addr;
        string name;
        string phoneNum;
        string residenceAddress;
    }

    function DirectDealing(string _name, string _phoneNum, string _residenceAddress, uint _VIN, uint _modelNo, string _carName,
        string _productYear, string _licenseNum, string _fuel){
        seller=new contractingParites()
        seller.name=_name;
        seller.phoneNum=_phoneNum;
        seller.residenceAddress=_residenceAddress;
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

    function buyerApprove(){
        
    }
}


