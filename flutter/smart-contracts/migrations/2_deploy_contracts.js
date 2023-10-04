var SmartContract=artifacts.require ("BossNFT.sol");

module.exports = function(deployer) {
    deployer.deploy(SmartContract);
}