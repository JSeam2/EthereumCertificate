
# Key steps
## To test the contract locally on ganache-cli
		ganache-cli -p 7545
		truffle compile
		truffle migrate --network development

		At this step look for CertificateFactory: 0x????????????
		This is the address you will need to replace the contract address in the index.js

    truffle console --network development
    CertificateFactory.deployed().then(inst => {CertInst = inst})

		CertInst.createCertificate("proof",web3.eth.accounts[1], "proof", "description")


## To run tests
    truffle test

# References 
https://hackernoon.com/ethereum-development-walkthrough-part-2-truffle-ganache-geth-and-mist-8d6320e12269
