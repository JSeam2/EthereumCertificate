if (typeof web3 !== "undefined"){
	var web3 = new Web3(web3.currentProvider);
} else {
	// to change to 8545 when deploying to testnet
	var web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545"));
}

// to fill up the abi
var abi = [
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"name": "certificates",
		"outputs": [
			{
				"name": "sender",
				"type": "address"
			},
			{
				"name": "senderProof",
				"type": "string"
			},
			{
				"name": "receiver",
				"type": "address"
			},
			{
				"name": "receiverProof",
				"type": "string"
			},
			{
				"name": "description",
				"type": "string"
			},
			{
				"name": "startTime",
				"type": "uint256"
			},
			{
				"name": "endTime",
				"type": "uint256"
			},
			{
				"name": "creationtime",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"name": "certificateToSender",
		"outputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"name": "certificateToReceiver",
		"outputs": [
			{
				"name": "",
				"type": "address"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "certificateId",
				"type": "uint256"
			},
			{
				"indexed": false,
				"name": "sender",
				"type": "address"
			},
			{
				"indexed": false,
				"name": "receiver",
				"type": "address"
			}
		],
		"name": "NewCertificate",
		"type": "event"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "_senderProof",
				"type": "string"
			},
			{
				"name": "_receiver",
				"type": "address"
			},
			{
				"name": "_receiverProof",
				"type": "string"
			},
			{
				"name": "_description",
				"type": "string"
			},
			{
				"name": "_startTime",
				"type": "uint256"
			},
			{
				"name": "_endTime",
				"type": "uint256"
			}
		],
		"name": "createCertificate",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	}
]; 

var CertificateFactory = web3.eth.contract(abi);

// to change address 
// after calling truffle deploy or truffle migrate --network development 
// look for this CertificateFactory: 0x2b14f63c6760177f48bc81f0c948de9880a69403
// Change the address respectively
contractAddress = "0xa929ec2e50d2283b5a6ea5b7a6677389335baf79"
contractInstance = CertificateFactory.at(contractAddress);

// In event if we need more fields
//table = {
//	1: ["cert-1", "sender-1", "receiver-1"],
//}


// not working
function createCertificate(form) {
	var sendProof = form.senderproof.val;

	// To check of recAddr is a valid ethereum address
	var recAddr = form.receiveraddr.val;
	var recProof = form.receiverproof.val; 
	var desc = form.description.val;

	var start = form.starttime.val;
	var end = form.endtime.val;

	alert(sendProof + "\n" + recAddr + "\n" + recProof + "\n" + desc + "\n" + start + "\n" + end);

	contractInstance.createCertificate(sendProof, recAddr, recProof, desc, start, end);
}

var event = contractInstance.NewCertificate(function(error, result) {
	if (error){
		console.log(error);
		return;
	} else {
		var _cert = document.getElementById("cert-1");
		var _sender = document.getElementById("sender-1");
		var _receiver = document.getElementById("receiver-1");

		_cert.innerHTML = result.args.certificateId;
		_sender.innerHTML = result.args.sender;
		_receiver.innerHTML = result.args.receiver;

	}
}) 
