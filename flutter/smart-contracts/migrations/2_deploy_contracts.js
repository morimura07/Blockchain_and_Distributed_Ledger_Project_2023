var bossNFT = artifacts.require("BossNFT.sol");
var adminNFT = artifacts.require("AdminNFT.sol");
var customerNFT = artifacts.require("CustomerNFT.sol");

module.exports = async function(deployer) {
    // deployer.deploy(bossNFT).then(
    //     function() {
    //         return deployer.deploy(adminNFT, bossNFT.address);
    //     }
    // );
    await deployer.deploy(bossNFT);
    await deployer.deploy(adminNFT, bossNFT.address);
    await deployer.deploy(customerNFT, adminNFT.address);
}