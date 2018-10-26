pragma solidity ^0.4.25;

import "./inspectionRecord.sol";

contract DealerDealing{

	contractingParites seller;
	bytes public sellerSign;
    contractingParites buyer;
    bytes public buyerSign;

	//매매업자 정보
	address agentAddr;
	string agentBoss;
	string agentNo;
	address bTransactorAddr;   //구매한 딜러 정보
    string bTransactorName;
    address sTransactorAddr;   //판매한 딜러 정보
    string sTransactorName;
    bytes public bTransactorSign;
    bytes public sTransactorSign;

    //거래내역 정보
    contractInfo buyInfo;
    contractInfo sellInfo;

    //차 내용
    uint VIN;
    string model;
    string carName;
	string productYear;
	string licenseNum;
	string fuel;

	//중고차 성능점검
	address inspectionRecord;
	// uint inspectionCost;
	// uint repairCost;

	bool buying;
	bool sellerApprove;
	bool sellerDecide;
	bool buyerApprove;
	bool buyerDecide;
	bool dealerApprove;
	bool dealerDecide;
	uint deposit;

    struct contractingParites{ 
        address addr;
        string name;
        string phoneNum;
        string residenceAddress;
    }

    struct contractInfo{
    	string date; //성사된 날짜
	    uint amount; //금액
	    string depositDate; //계약금 지불 일
	    uint deposit; //계약금
	    string middleDate; //중도금 지불 날짜
	    uint middlePayment; //중도금
	    string balanceDate; //잔액 지불 날짜
	    uint balance; //잔액
	    string deliveryDate;  //인도한 날짜
    }
   
	constructor(address _owner, string _agentBoss, string _agentNo){
		agentAddr=_owner;
		agentBoss=_agentBoss;
		agentNo=_agentNo;
		tmp=new inspectionRecord( _VIN, _model, _carName, _productYear, _licenseNum, 
			_fuel, _transmission);
		inspectionRecord=address(tmp);
	}


	//판매자 정보 설정.
	function setSeller(string _name, string _phoneNum, string _residenceAddress){
		seller=contractingParites(msg.sender, _name, _phoneNum, _residenceAddress);
		sellerDecide=true;
		sellerApprove=_decide;
		sellerSign=sha256(msg.sender, buyInfo.date, buyInfo.amount, buyInfo.balanceDate, 
			buyInfo.balance, buyInfo.deliveryDate);
	}

	//구매한 딜러 정보 설정
	function setBDealer(string _name){
		bTransactorAddr=msg.sender;
		bTransactorName=_name;
		dealerDecide=true;
		dealerApprove=_decide;
		bTransactorSign=sha256(msg.sender, buyInfo.date, buyInfo.amount, buyInfo.balanceDate, 
			buyInfo.balance, buyInfo.deliveryDate);
	}

	//판매한 딜러 정보 설정
	function setSDealer(string _name){
		sTransactorAddr=msg.sender;
		sTransactorName=_name;
		dealerDecide=true;
		dealerApprove=_decide;
		sTransactorSign=sha256(msg.sender, sellInfo.date, sellInfo.amount, sellInfo.balanceDate, 
			sellInfo.balance, sellInfo.depositDate, sellInfo.deposit, sellInfo.deliveryDate);
	}

	// 구매자 정보 설정.
	function setBuyer(string _name, string _phoneNum, string _residenceAddress){
		buyer=contractingParites(msg.sender, _name, _phoneNum, _residenceAddress);
		buyerDecide=true;
		buyerApprove=_decide;
		buyerSign=sha256(msg.sender, sellInfo.date, sellInfo.amount, sellInfo.balanceDate, sellInfo.balance, sellInfo.depositDate,
			sellInfo.deposit, sellInfo.deliveryDate);
	}


	function setBuyInfo(string _date,uint _amount, string _deliveryDate){	
		buyInfo=contractInfo(_date, _amount,"0",0,"0",0,_date,_amount, _deliveryDate);
	}

	function setSellInfo(string _date,uint _amount){	
		sellInfo=contractInfo(_date, _amount,"0",0,"0",0,"0",0,"0");
	}

	function setDeposit(string _depositDate,uint _deposit){
		sellInfo.depositDate=_depositDate;
		sellInfo.deposit=_deposit;
	}

	function setBalance(string _balanceDate,uint _balance){
		sellInfo.balanceDate=_balanceDate;
		sellInfo.balance=_balance;
	}
	function setDeliveryDate(string _deliveryDate){
		sellInfo.deliveryDate=_deliveryDate;
	}


	//성능 점검 기록부 받을 때 차의 추정값 산정.
	function setEstimateValue(uint _estimateValue){
		estimateValue=_estimateValue;
	}

	//정비 비용 
	function setRefairCost(uint _repairCost){
		repairCost=_repairCost;
	}


	//get 함수
	function getCarInfo() public view returns(uint VIN, string model, string carName, string productYear, 
		string licenseNum, string fuel){
		return(VIN, model, carName, productYear, licenseNum, fuel);
	}
	
	function getInspectionRecord()public view return(address inspectionRecord){
		return(inspectionRecord);
	}

	function getBuyInfo() public view returns(
			string name, string residenceAddress,
			string bTransactorName,
			string date, uint amount, string balanceDate, uint balance, string deliveryDate ){
		return(seller.name, seller.residenceAddress,
			bTransactorName,
			buyInfo.date, buyInfo.amount, buyInfo.balanceDate, buyInfo.balance, buyInfo.deliveryDate);
	}
	function getSellInfo() public view returns(
			string name, string residenceAddress,
			string sTransactorName,
			string date, uint amount, string balanceDate, uint balance, 
			string depositDate, uint deposit, string deliveryDate ){
		return(buyer.name, buyer.residenceAddress,
			sTransactorName,
			sellInfo.date, sellInfo.amount, sellInfo.balanceDate, sellInfo.balance, sellInfo.depositDate,
			sellInfo.deposit, sellInfo.deliveryDate);
	}
}
	// function confirmApprove(){
	// 	if(buying){
	// 		if(sellerDecide && dealerDecide){
	// 			if(sellerApprove && dealerApprove){

	// 			}else if(!sellerApprove && dealerApprove){

	// 			}else if(sellerApprove && !dealerApprove){

	// 			}else{

	// 			}
	// 		}
	// 	}else{
	// 		if(buyerDecide && dealerDecide){
	// 			if(buyerApprove && dealerApprove){   //둘다 오케이

	// 			}else if(!buyerApprove && dealerApprove){  //구매자만 노

	// 			}else if(buyerApprove && !dealerApprove){   //딜러만 노

	// 			}else{

	// 			}
	// 		}
	// 	}
	// }
//거래 동의 함수.
	// function setSellerApprove(bool _decide){
	// 	require(msg.sender==seller.addr);
		
	// 	sellerDecide=true;
	// 	sellerApprove=_decide;
	// 	confirmApprove();
	// }

	// function setDealerApprove(bool _decide){
	// 	if(buying)require(msg.sender==bTransactorAddr);
	// 	else require(msg.sender==sTransactorAddr);

	// 	dealerDecide=true;
	// 	dealerApprove=_decide;
	// 	confirmApprove();
	// }

	// function setBuyerApprove(bool _decide){
	// 	require(msg.sender==buyer.addr);

	// 	buyerDecide=true;
	// 	buyerApprove=_decide;
	// 	confirmApprove();
	// }
//거래 생성자는 판매자
	// function DealerDealing(string _name, string _phoneNum, string _residenceAddress, uint _VIN, string _model, string _carName,
	// 	string _productYear, string _licenseNum, string _fuel ){
	// 	seller=contractingParites(msg.sender, _name, _phoneNum, _residenceAddress);
	// 	VIN=_VIN;
	// 	model=_model;
	// 	carName=_carName;
	// 	productYear=_productYear;
	// 	licenseNum=_licenseNum;
	// 	fuel=_fuel;
	// 	sellerApprove=false;
	// 	dealerApprove=false;
	// 	buyerApprove=false;
	// 	sellerDecide=false;
	// 	dealerDecide=false;
	// 	buyerDecide=false;
	// 	buying=true;
	// 	inspectionRecord=new inspectionRecord( _VIN, _model, _carName, _productYear, _licenseNum, 
	// 		_fuel, _transmission);
	// }



	/*차를 판매할땐,
		판매자는 차의 성능점검을 받아보고 안팔 경우가 있다.
		그렇기 떄문에 판매자는 그에 대한 비용을 미리 보증금으로 걸어놓고 파는것을 취소할땐 보증금을 돌려받지 못한다.
		딜러가 차를 산다고했다가 안사는 경우가 있을까? 없을걸...

	  차를 살땐,
	  	구매자는 차를 산다고 했다가 안사는 경우가 있다.
	  	그렇기 때문에 구매자는 계약금(보증금)을 걸어두어야 한다. 취소할땐 보증금을 못돌려 받는다.
	  	딜러는 판매한다고 유인해놓고 차를 안팔거나 할 수 있다. 안팔때 보증금을 돌려 받지 못한다.
	*/
	// function setDeposit(){
	// 	deposit=deposit+(msg.value/1000000000000000000);
	// }