const CertificateFactory = artifacts.require("./CertificateFactory.sol");

module.exports = function(deployer) {
	deployer.deploy(CertificateFactory);
};

