pragma solidity ^0.4.25;

/**
 * Tht InspectionRecord
 contract does this and that...
 */
contract InspectionRecord {
    contractingParites public inspector;
    contractingParites public notifier;
    contractingParites public assessor;
    bytes public inspectorSign;
    bytes public notifierSign;
    bytes public assessorSign;


     //차 기본 내용
    uint modelNo;
    string carName;
    string licenseNum;
    string productYear;
    uint VIN;
    uint transmission;
    string fuel;
    bytes basicSign;

    //종합 상태
    uint8 dashboardStatus; 
    uint mileage;
    uint8 VINStatus;
    bool tuning;
    uint8 specialRecord; // 0: 없다, 1:침수, 2:화재
    uint8 usageChange; // 0: 없다, 1:렌트, 2:리스, 3:영업
    string color;
    bytes overAllSign;

    //사고 교환 수리 이력
    uint8[] status; //0: 없음, 1:교환, 2:판큼,용접, 3:흡집, 4:요철, 5:부식, 6:손상
    bool isAccidentHistory;
    bool simpleRepair;
    bool[] outsideA;
    bool[] outsideB;
    bool[] frame;
    bytes historySign;

    //세부상태
    uint8 enginStatus;
    uint8 transmissionStatus;
    uint8 oilLeak;
    uint8 coolantLeak;
    uint8 clutch;
    uint8 stearing;
    uint8 breakStatus;
    uint8 wiper;
    uint8 airConditioner;
    uint8 fuelLeak;
    bytes detailSign;

    //수리필요
    uint8 outside;
    uint8 inside;
    uint8 wheel;
    uint8 tire;
    uint8 window;
    bytes needRepairSign;

    uint estimateValue;  // 가격 추산
    bytes estimateValueSign;
    uint public date; //점검일
    uint public guarantee;  //보증기간

    struct contractingParites{
        address agentAddr;
        string agentNo;
        string agentName;
        address addr;
        string name;
        string phoneNum;
    }

    function InspectionRecord(uint _VIN, uint _modelNo, string _carName, string _productYear,
        string _licenseNum, string _fuel, uint _transmission) {
        modelNo=_modelNo;
        carName=_carName;
        licenseNum=_licenseNum;
        productYear=_productYear;
        VIN=_VIN;
        fuel=_fuel;
        transmission=_transmission;
        basicSign=sha256(modelNo, carName, licenseNum, productYear, VIN, fuel, transmission);
    }

    function setInspector(address _agentAddr, string _agentNo, string _agentName,
        string _name, string _phoneNum){
        inspector=contractingParites(_agentAddr, _agentNo, _agentName, msg.sender, _name, _phoneNum);
    }

    function setNotifier(address _agentAddr, string _agentNo, string _agentName,
        string _name, string _phoneNum){
        notifier=contractingParites(_agentAddr, _agentNo, _agentName, msg.sender, _name, _phoneNum);
    }

    function setAssessor(address _agentAddr, string _agentNo, string _agentName,
        string _name, string _phoneNum){
        assessor=contractingParites(_agentAddr, _agentNo, _agentName, msg.sender, _name, _phoneNum);
    }

    function signInspector(){
        require(msg.sender==inspector.addr);
        inspectorSign=sha256(basicSign, overAllSign, historySign, detailSign, needRepairSign);
    }

    function signNotifier(){
        require(msg.sender==notifier.addr);
        notifierSign=sha256(basicSign, overAllSign, historySign, detailSign, needRepairSign);
    }

    function signAssessor(){
        require(msg.sender==assessor.addr);
        assessorSign=sha256(estimateValueSign);
    }


    function setOverall( uint8 _dashboardStatus, uint _mileage,  bool _tuning, 
        uint8 _specialRecord, string _color){
        dashboardStatus=_dashboardStatus; 
        mileage=_mileage;
        tuning=_tuning;
        specialRecord=_specialRecord;
        color=_color;
        overAllSign=sha256(dashboardStatus, mileage, tuning, specialRecord, color);
    }

    function setHistory(bool _isAccidentHistory, bool _simpleRepair){
        isAccidentHistory=_isAccidentHistory;
        simpleRepair=_simpleRepair;
        historySign=sha256(isAccidentHistory, simpleRepair);
    }

    function setDetail(uint8 _enginStatus, uint8 _transmissionStatus, uint8 _oilLeak, uint8 _coolantLeak,
        uint8 _clutch, uint8 _stearing, uint8 _breakStatus, uint8 _wiper, uint8 _airConditioner, 
        uint8 _fuelLeak){
        enginStatus=_enginStatus;
        transmissionStatus=_transmissionStatus;
        oilLeak=_oilLeak;
        coolantLeak=_coolantLeak;
        clutch=_clutch;
        stearing=_stearing;
        breakStatus=_breakStatus;
        wiper=_wiper;
        airConditioner=_airConditioner;
        fuelLeak=_fuelLeak;
        detailSign=sha256(enginStatus, transmissionStatus, oilLeak, coolantLeak, clutch, stearing 
            breakStatus, wiper, airConditioner, fuelLeak);
    }

    function setNeedRepair(uint8 _outside, uint8 _inside, uint8 _wheel, uint8 _tire, uint8 _window){
        outside=_outside;
        inside=_inside;
        wheel=_wheel;
        tire=_tire;
        window=_window;
        needRepairSign=sha256(outside, inside, wheel, tire, window);
    }

    function setEstimateValue(uint _estimateValue){
        estimateValue=_estimateValue;
        estimateValueSign=sha256(estimateValue);
    }

    function setDate(uint _date){
        date=_date;
    }

    function setGuarantee(uint _guarantee){
        guarantee=_guarantee;
    }

    function getInfo() view returns (uint, string, string, string, uint, uint, string){
        return (modelNo, carName, licenseNum, productYear, VIN, transmission, fuel);
    }
    function getParites() view returns (uint8, uint,  bool, uint8, string){
        return (dashboardStatus, mileage, tuning, specialRecord, color);
    }

    function getOverall() view returns (uint8, uint,  bool, uint8, string){
        return (dashboardStatus, mileage, tuning, specialRecord, color);
    }

    function getHistory() view returns (bool, bool){
        return(isAccidentHistory, simpleRepair);
    }

    function getDetail() view returns (uint8, uint8, uint8, uint8, uint8, uint8, uint8, uint8, uint8, uint8){
        return(enginStatus, transmissionStatus, oilLeak, coolantLeak, clutch,
            stearing, breakStatus, wiper, airConditioner, fuelLeak);
    }

    function getNeedRepair() view returns (uint8, uint8, uint8, uint8, uint8){
        return(outside, inside, wheel, tire, window);
    }
}
