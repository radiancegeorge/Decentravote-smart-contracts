const test = artifacts.require("Test");

module.exports = (deployer) => {
  deployer.deploy(test);
};
