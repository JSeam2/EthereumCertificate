references 
https://hackernoon.com/ethereum-development-walkthrough-part-2-truffle-ganache-geth-and-mist-8d6320e12269

Key steps
ganache-cli -p 7545
truffle compile
truffle migrate --network development
	At this step look for CertificateFactory: 0x????????????
	This is the address you will need to replace the contract address in the index.js

truffle console --network development
account0 = web3.eth.accounts[0]
account1 = web3.eth.accounts[1]
CertificateFactory.deployed().then(inst => {CertInst = inst})

To replace the address
CertInst.createCertificate("proof",web3.eth.accounts[1], "proof", "description")
