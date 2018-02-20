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



  event NewCertificate(uint certificateId, address sender, address receiver);

  // Array of certs for the contract
  Certificate[] public certificates;

  // Mapping for sender
  mapping(uint => address) public certificateToSender;
  mapping(address => uint) senderCertificateCount; 

  // Mapping for receiver
  mapping(uint => address) public certificateToReceiver;
  mapping(address => uint) receiverCertificateCount;

  
  function createCertificate(string _senderProof,
                             address _receiver, 
                             string _receiverProof,
                             string _description,
                             uint256 _startTime, 
                             uint256 _endTime) public {
    
    // TODO check if all fields are valid
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
