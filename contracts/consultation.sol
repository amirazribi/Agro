// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Consultation {
    struct ConsultationDetail {
        string medicName;
        string patientAddress; // "address" est un mot clé réservé en Solidity, il faut le renommer
        uint256 price;
    }

    mapping(uint256 => ConsultationDetail) public consultations;
    uint256 public consultationCount;

    event ConsultationConfirmed(uint256 indexed consultationId, string medicName, string patientAddress, uint256 price);

    function confirmConsultation(string memory _medicName, string memory _patientAddress, uint256 _price) public {
        consultationCount++;
        consultations[consultationCount] = ConsultationDetail(_medicName, _patientAddress, _price);
        emit ConsultationConfirmed(consultationCount, _medicName, _patientAddress, _price);
    }

    function getConsultation(uint256 _consultationId) public view returns (string memory, string memory, uint256) {
        ConsultationDetail memory consultation = consultations[_consultationId];
        return (consultation.medicName, consultation.patientAddress, consultation.price);
    }
}
