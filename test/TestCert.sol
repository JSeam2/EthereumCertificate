pragma solidity ^0.4.19;

import "../contracts/CertificateFactory.sol";
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";

contract TestCert {
  address constant receiver = 0xe73C9F0bD48A4939BB44f4B2E2D6030Ce38e9B51;

  // check if sender address is correct
  function testSenderAdress() public {
    CertificateFactory certFact = new CertificateFactory();

    certFact.createCertificate("senderProof", 
                                receiver,
                               "receiverProof",
                               "description");

   // note as we are doing testing this refers to the contract
   // contract acts as msg.sender
   Assert.equal(certFact.certificateToSender(0), 
                this, 
                "Sender Address not the same");
  }


  // check if receiver address is correct
  function testReceiverAddress() public {
    CertificateFactory certFact = new CertificateFactory();

    certFact.createCertificate("senderProof", 
                                receiver,
                               "receiverProof",
                               "description");

   Assert.equal(certFact.certificateToReceiver(0), 
                0xe73C9F0bD48A4939BB44f4B2E2D6030Ce38e9B51, 
                "Receiver Address not the same");
  }


  // Unable to check strings or byte32 from mapping
  // These are treated as dynamic objects and cannot be compard
  //function testReceiverProof() public {
  //  CertificateFactory certFact = new CertificateFactory();

  //  certFact.createCertificate("senderProof", 
  //                              0xe73C9F0bD48A4939BB44f4B2E2D6030Ce38e9B51,
  //                             "receiverProof",
  //                             "description");


  //  Assert.equal(keccak256(certFact.certificateToReceiverProof(0)),
  //              keccak256("receiverProof"),
  //              "Receiver Proof not the same");
  //}


  function testFailSenderProof() public {
    CertificateFactory certFact = new CertificateFactory();
		ThrowProxy throwproxy = new ThrowProxy(address(certFact));

    CertificateFactory(address(throwproxy)).createCertificate("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", 
                                receiver,
                               "receiverProof",
                               "description");

		bool r = throwproxy.execute.gas(1000000)();

    Assert.isFalse(r, "Should return false as sender proof is too long");

  }


  function testFailReceiverProof() public {
    CertificateFactory certFact = new CertificateFactory();
		ThrowProxy throwproxy = new ThrowProxy(address(certFact));

    CertificateFactory(address(throwproxy)).createCertificate("senderProof", 
                                receiver,
                               "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                               "description");

		bool r = throwproxy.execute.gas(1000000)();

    Assert.isFalse(r, "Should return false as receiver proof is too long");

  }


  function testFailDescription() public {
    CertificateFactory certFact = new CertificateFactory();
		ThrowProxy throwproxy = new ThrowProxy(address(certFact));

    CertificateFactory(address(throwproxy)).createCertificate("senderProof", 
                                receiver,
                               "receiverProof",
                               "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");

		bool r = throwproxy.execute.gas(1000000)();

    Assert.isFalse(r, "Should return false as description is too long");

  }
}


// Proxy contract for testing throws
contract ThrowProxy {
  address public target;
  bytes data;

  function ThrowProxy(address _target) {
    target = _target;
  }

  //prime the data using the fallback function.
  function() public {
    data = msg.data;
  }

  function execute() public returns (bool) {
    return target.call(data);
  }
}
