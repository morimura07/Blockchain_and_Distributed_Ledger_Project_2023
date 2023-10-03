const SmartContract = artifacts.require("BossNFT");

module.exports = function (deployer) {
  deployer.deploy(SmartContract);
};