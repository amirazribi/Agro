const AnalysisContract = artifacts.require("./AnalysisContract");

module.exports = function(deployer) {
  deployer.deploy(AnalysisContract);
};