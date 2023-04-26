const dvt = artifacts.require("DVT");

module.exports = (deployer) => {
  deployer.deploy(dvt, 10000000);
};
