pragma solidity ^0.4.26;

contract DealerDealing{

	contractingParites seller;
    contractingParites buyer;
    
    contractingParites assessor;
	//매매업자 정보
	address agentAddr;
	string agentBoss;
	string agentNo;
	address bTransactorAddr;   //구매한 딜러 정보
    string bTransactorName;
    address sTransactorAddr;   //판매한 딜러 정보
    string sTransactorName;

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
   
    //거래 생성자는 판매자
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
		sellerApprove=false;
		dealerApprove=false;
		buyerApprove=false;
		sellerDecide=false;
		dealerDecide=false;
		buyerDecide=false;
		buying=true;
	}



	// 판매자 정보 설정.
	function setSeller(string _name, string _phoneNum, string _residenceAddress){
		seller=contractingParites(msg.sender, _name, _phoneNum, _residenceAddress);
	}

	//구매한 딜러 정보 설정
	function setBDealer(string _name){
		bTransactorAddr=msg.sender;
		bTransactorName=_name;
	}

	//판매한 딜러 정보 설정
	function setSDealer(string _name){
		sTransactorAddr=msg.sender;
		sTransactorName=_name;
	}
	// 구매자 정보 설정.
	function setBuyer(string _name, string _phoneNum, string _residenceAddress){
		buyer=contractingParites(msg.sender, _name, _phoneNum, _residenceAddress);
	}



	//거래 동의 함수.
	function setSellerApprove(bool _decide){
		if(msg.sender!=seller.addr) return;
		
		sellerDecide=true;
		sellerApprove=_decide;
		confirmApprove();
	}

	function setDealerApprove(bool _decide){
		if(buying)if(msg.sender!=bTransactorAddr) return;
		else if(selling)if(msg.sender!=sTransactorAddr) return;

		dealerDecide=true;
		dealerApprove=_decide;
		confirmApprove();
	}

	function setBuyerApprove(bool _decide){
		if(msg.sender!=buyer.addr) return;

		buyerDecide=true;
		buyerApprove=_decide;
		confirmApprove();
	}

	function confirmApprove(){
		if(buying){
			if(sellerDecide && dealerDecide){
				if(sellerApprove && dealerApprove){

				}else if(!sellerApprove && dealerApprove){

				}else if(sellerApprove && !dealerApprove){

				}else{

				}
			}
		}else{
			if(buyerDecide && dealerDecide){
				if(buyerApprove && dealerApprove){   //둘다 오케이

				}else if(!buyerApprove && dealerApprove){  //구매자만 노

				}else if(buyerApprove && !dealerApprove){   //딜러만 노

				}else{

				}
			}
		}
	}

	function setInspectionRecord(){

	}

	//성능 점검 기록부 받을 때 차의 추정값 산정.
	function setEstimateValue(uint _estimateValue){
		estimateValue=_estimateValue;
	}

	//정비 비용 
	function setRefairCost(uint _repairCost){
		repairCost=_repairCost;
	}


	
	/*차를 판매할땐,
		판매자는 차의 성능점검을 받아보고 안팔 경우가 있다.
		그렇기 떄문에 판매자는 그에 대한 비용을 미리 보증금으로 걸어놓고 파는것을 취소할땐 보증금을 돌려받지 못한다.
		딜러가 차를 산다고했다가 안사는 경우가 있을까? 없을걸...

	  차를 살땐,
	  	구매자는 차를 산다고 했다가 안사는 경우가 있다.
	  	그렇기 때문에 구매자는 계약금(보증금)을 걸어두어야 한다. 취소할땐 보증금을 못돌려 받는다.
	  	딜러는 판매한다고 유인해놓고 차를 안팔거나 할 수 있다. 안팔때 보증금을 돌려 받지 못한다.
	*/
	function setDeposit(){
		deposit=deposit+(msg.value/1000000000000000000);
	}


}
