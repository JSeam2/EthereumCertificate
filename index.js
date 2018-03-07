if (typeof web3 !== "undefined"){
	var web3 = new Web3(web3.currentProvider);
} else {
	// to change to 8545 when deploying to testnet
	var web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545"));
}

//abi
var certificatefactoryContract = web3.eth.contract([{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"certificateToSender","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"certificateToCreateTime","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"certificateToReceiver","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"certificateToReceiverProof","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"certificates","outputs":[{"name":"sender","type":"address"},{"name":"senderProof","type":"string"},{"name":"receiver","type":"address"},{"name":"receiverProof","type":"string"},{"name":"description","type":"string"},{"name":"creationtime","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_senderProof","type":"string"},{"name":"_receiver","type":"address"},{"name":"_receiverProof","type":"string"},{"name":"_description","type":"string"}],"name":"createCertificate","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"certificateToSenderProof","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"certificateToDescription","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"anonymous":false,"inputs":[{"indexed":false,"name":"certificateId","type":"uint256"},{"indexed":false,"name":"sender","type":"address"},{"indexed":false,"name":"senderProof","type":"string"},{"indexed":false,"name":"receiver","type":"address"},{"indexed":false,"name":"receiverProof","type":"string"},{"indexed":false,"name":"description","type":"string"},{"indexed":false,"name":"creationTime","type":"uint256"}],"name":"NewCertificate","type":"event"}]);

// to change address 
// after calling truffle deploy or truffle migrate --network development 
// look for this CertificateFactory: 0x2b14f63c6760177f48bc81f0c948de9880a69403
// Change the address respectively
contractAddress = "0xe9c66379ae00cd162841d234cef81e883fcd8eda" 
contractInstance = certificatefactoryContract.at(contractAddress);


// If login currently login is not settled so this is not done
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
		var _cert1 = document.getElementById("cert-1");
		var _sender1 = document.getElementById("sender-1");
		var _senderproof1 = document.getElementById("sender-proof-1"); 
		var _receiver1 = document.getElementById("receiver-1");
		var _receiverproof1 = document.getElementById("receiver-proof-1"); 
		var _description1 = document.getElementById("description-1"); 
		var _createTime1 = document.getElementById("createtime-1");

		var currentID = result.args.certificateId;

		_cert1.innerHTML = result.args.certificateId;
		_sender1.innerHTML = result.args.sender;
		_senderproof1.innerHTML = result.args.senderProof;
		_receiver1.innerHTML = result.args.receiver;
		_receiverproof1.innerHTML = result.args.receiverProof;
		_description1.innerHTML = result.args.description;

		var _date = new Date(result.args.creationTime * 1000);
		_createTime1.innerHTML = _date;

		if((currentID - 1) >= 0){
			var _currentID = currentID - 1;

			var _cert2 =			document.getElementById("cert-2");
			var _sender2 =			document.getElementById("sender-2");
			var _senderproof2 =		document.getElementById("sender-proof-2"); 
			var _receiver2 =		document.getElementById("receiver-2");
			var _receiverproof2 =	document.getElementById("receiver-proof-2"); 
			var _description2 =		document.getElementById("description-2"); 
			var _createTime2 =		document.getElementById("createtime-2");

			_cert2.innerHTML =			_currentID; 
			_sender2.innerHTML =		contractInstance.certificateToSender(_currentID);
			_senderproof2.innerHTML =	contractInstance.certificateToSenderProof(_currentID);
			_receiver2.innerHTML =		contractInstance.certificateToReceiver(_currentID);
			_receiverproof2.innerHTML = contractInstance.certificateToReceiverProof(_currentID); 
			_description2.innerHTML =	contractInstance.certificateToDescription(_currentID);
			_createTime2.innerHTML =	new Date(contractInstance.certificateToCreateTime(currentID) * 1000);
		}

		if((currentID - 2) >= 0){
			var _currentID = currentID - 2;

			var _cert3 =			document.getElementById("cert-3");
			var _sender3 =			document.getElementById("sender-3");
			var _senderproof3 =		document.getElementById("sender-proof-3"); 
			var _receiver3 =		document.getElementById("receiver-3");
			var _receiverproof3 =	document.getElementById("receiver-proof-3"); 
			var _description3 =		document.getElementById("description-3"); 
			var _createTime3 =		document.getElementById("createtime-3");

			_cert3.innerHTML =			_currentID; 
			_sender3.innerHTML =		contractInstance.certificateToSender(_currentID);
			_senderproof3.innerHTML =	contractInstance.certificateToSenderProof(_currentID);
			_receiver3.innerHTML =		contractInstance.certificateToReceiver(_currentID);
			_receiverproof3.innerHTML = contractInstance.certificateToReceiverProof(_currentID); 
			_description3.innerHTML =	contractInstance.certificateToDescription(_currentID);
			_createTime3.innerHTML =	new Date(contractInstance.certificateToCreateTime(currentID) * 1000);
		}

		if((currentID - 3) >= 0){
			var _currentID = currentID - 3;

			var _cert4 =			document.getElementById("cert-4");
			var _sender4 =			document.getElementById("sender-4");
			var _senderproof4 =		document.getElementById("sender-proof-4"); 
			var _receiver4 =		document.getElementById("receiver-4");
			var _receiverproof4 =	document.getElementById("receiver-proof-4"); 
			var _description4 =		document.getElementById("description-4"); 
			var _createTime4 =		document.getElementById("createtime-4");

			_cert4.innerHTML =			_currentID; 
			_sender4.innerHTML =		contractInstance.certificateToSender(_currentID);
			_senderproof4.innerHTML =	contractInstance.certificateToSenderProof(_currentID);
			_receiver4.innerHTML =		contractInstance.certificateToReceiver(_currentID);
			_receiverproof4.innerHTML = contractInstance.certificateToReceiverProof(_currentID); 
			_description4.innerHTML =	contractInstance.certificateToDescription(_currentID);
			_createTime4.innerHTML =	new Date(contractInstance.certificateToCreateTime(currentID) * 1000);
		}

		if((currentID - 4) >= 0){
			var _currentID = currentID - 4;

			var _cert5 =			document.getElementById("cert-5");
			var _sender5 =			document.getElementById("sender-5");
			var _senderproof5 =		document.getElementById("sender-proof-5"); 
			var _receiver5 =		document.getElementById("receiver-5");
			var _receiverproof5 =	document.getElementById("receiver-proof-5"); 
			var _description5 =		document.getElementById("description-5"); 
			var _createTime5 =		document.getElementById("createtime-5");

			_cert5.innerHTML =			_currentID; 
			_sender5.innerHTML =		contractInstance.certificateToSender(_currentID);
			_senderproof5.innerHTML =	contractInstance.certificateToSenderProof(_currentID);
			_receiver5.innerHTML =		contractInstance.certificateToReceiver(_currentID);
			_receiverproof5.innerHTML = contractInstance.certificateToReceiverProof(_currentID); 
			_description5.innerHTML =	contractInstance.certificateToDescription(_currentID);
			_createTime5.innerHTML =	new Date(contractInstance.certificateToCreateTime(currentID) * 1000);
		}
	}
});
