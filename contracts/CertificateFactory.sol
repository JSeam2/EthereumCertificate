pragma solidity ^0.4.19;

contract CertificateFactory {

  struct Certificate {
    address sender;
    string senderProof; // to be encrypted

    address receiver;
    string receiverProof; // to be encrypted

    string description; // to be encrypted

    uint256 startTime;
    uint256 endTime;

    uint256 creationtime; // to be generated upon calling of NewCertificate
  }



  event NewCertificate(uint certificateId, 
                       address sender, 
                       string senderProof, 
                       address receiver,
                       string receiverProof,
                       string description,
                       uint256 startTime,
                       uint256 endTime,
                       uint256 creationTime);

  // Array of certs for the contract
  Certificate[] public certificates;

  // Mapping for sender
  mapping(uint256 => address) public certificateToSender;
  mapping(uint256 => string) public certificateToSenderProof;
  mapping(address => uint256) senderCertificateCount; 

  // Mapping for receiver
  mapping(uint256 => address) public certificateToReceiver;
  mapping(uint256 => string) public certificateToReceiverProof;
  mapping(address => uint256) receiverCertificateCount;

  // Mapping for description
  mapping(uint256 => string) public certificateToDescription;

  // Mapping for timings
  mapping(uint256 => uint256) public certificateToStartTime;
  mapping(uint256 => uint256) public certificateToEndTime;
  mapping(uint256 => uint256) public certificateToCreateTime;
  
  function createCertificate(string _senderProof,
                             address _receiver, 
                             string _receiverProof,
                             string _description,
                             uint256 _startTime, 
                             uint256 _endTime) public {
    
    // TODO check if all fields are valid
    // TODO limit fields to prevent infinite gas
    // TODO encrypt field

    uint256 _creationTime = now;
    address _sender = msg.sender;
    uint256 id = certificates.push(Certificate(_sender, 
                                        _senderProof,                    
                                        _receiver, 
                                        _receiverProof,
                                        _description,
                                        _startTime, 
                                        _endTime,
                                        _creationTime)) - 1;


    // mappings
    certificateToSender[id] = _sender;
    senderCertificateCount[_sender]++;
    certificateToSenderProof[id] = _senderProof;

    certificateToReceiver[id] = _receiver;
    receiverCertificateCount[_receiver]++;
    certificateToReceiverProof[id] = _receiverProof;

    certificateToDescription[id] = _description;

    certificateToStartTime[id] = _startTime;
    certificateToEndTime[id] = _endTime;
    certificateToCreateTime[id] = _creationTime;

    // call event
    NewCertificate(id,
                   _sender,
                   _senderProof,
                   _receiver,
                   _receiverProof,
                   _description,
                   _startTime,
                   _endTime,
                   _creationTime);
  }

}

