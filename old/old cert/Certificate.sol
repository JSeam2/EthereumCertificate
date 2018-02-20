pragma solidity ^0.4.20;


// to look for uint which we can potentially reduce to reduce storage cost

contract CertificateFactory {
  // State machine
  // Prevent potential reputation attack allows recipient to reject certificate
  //enum Stages{
  //  SenderSendCertificate,
  //  ReceiverAcceptCertificate,
  //  Completed
  //}

  struct Certificate {
    // Details of Sender
    address sender;
    string senderProof; // to be encrypted

    // Details of Receiver
    address receiver;
    string receiverProof; // to be encrypted

    // Description of the certificate
    string description; // to be encrypted

    // Validity of Certificate, set both to 0 for unlimited
    uint256 startTime;
    uint256 endTime;

    uint256 creationtime = now;
  }

  // Certificate meta data
  // Stages public stage = Stages.SenderSendCertificate;
  

  // Prevents illegal state transition
  //modifier atStage(Stages _stage){
  //  require(stage == _stage);
  //  _;
  //}

  //function nextStage() internal {
  //  stage = Stages(uint(stage) + 1);
  //}



  event NewCertificate(uint certificateId, address sender, address receiver);

  // Array of certs for the contract
  Certificate[] public certificates;

  // Mapping for sender
  mapping(uint => address) public certificiateToSender;
  mapping(address => uint) senderCertificateCount; 

  // Mapping for receiver
  mapping(uint => address) public certificateToReceiver;
  mapping(address => uint) receiverCertificateCount;

  
  function _createCertficate(string _senderProof,
                       address _receiver, string _receiverProof,
                       string _description,
                       uint256 _startTime, uint256 _endTime) internal {
    
    // TODO check if all fields are valid
    // TODO encrypt field

    address _sender = msg.sender;
    uint id = certs.push(Certificate(_sender, _senderProof,                    
                                     _receiver, _receiverProof,
                                     _description,
                                     _startTime, _endTime)) - 1;


    // map the certificate id to the sender and receiver
    certificateToSender[id] = _sender;
    senderCertificateCount[_sender]++;

    certificateToReceiver[id] = _receiver;
    receiverCertificateCount[_receiver]++;

    // call event
    NewCertificate(id, _sender, _receiver);
    
    // produce an encryption token
  }

}
