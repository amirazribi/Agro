const Consultation = artifacts.require("Consultation"); // Assurez-vous que le nom ici correspond au nom réel du contrat

module.exports = function(deployer) {
  deployer.deploy(Consultation);
};
