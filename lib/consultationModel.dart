import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web3dart/web3dart.dart';

class ConsultationModel {
  final String _rpcUrl = "http://127.0.0.1:7545"; // L'URL du nœud RPC HTTP
  final String _wsUrl = "ws://127.0.0.1:7545/"; // L'URL du nœud WebSockets
  final String _privateKey = "0xc219788efc22892ac55ae8348ffa28e2ed92a57d77b93d3080b78428e0889bac"; // Remplacez par votre clé privée

  late Web3Client _client;
  late String _abiCode;
  late EthereumAddress _contractAddress;
  late Credentials _credentials;
  late EthereumAddress _ownAddress;

  late DeployedContract _contract;
  late ContractFunction _confirmConsultationFunction;
  late ContractFunction _getConsultationFunction;

  ConsultationModel();

  Future<void> initiateSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });

    await _getAbi();
    await _getCredentials();
    await _getDeployedContract();
  }

  Future<void> _getAbi() async {
    String abiStringFile = await rootBundle.loadString('assets/consultation.json');
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi['abi']);

    _contractAddress = EthereumAddress.fromHex("0x5f63d98a7FB46932fFea6d737C99F3D62C8F6489"); // Remplacez par l'adresse de votre contrat déployé
  }

  Future<void> _getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
    _ownAddress = await _credentials.extractAddress();
  }

  Future<void> _getDeployedContract() async {
    _contract = DeployedContract(ContractAbi.fromJson(_abiCode, 'Consultation'), _contractAddress);
    _confirmConsultationFunction = _contract.function('confirmConsultation');
    _getConsultationFunction = _contract.function('getConsultation');
  }

  Future<String> confirmConsultation(String medicName, String patientAddress, BigInt price) async {
    final transaction = await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: _confirmConsultationFunction,
        parameters: [medicName, patientAddress, price],
        maxGas: 100000,
      ),
      chainId: 1337,
      fetchChainIdFromNetworkId: false,
    );

    return transaction;
  }

  Future<List<dynamic>> getConsultation(int consultationId) async {
    final result = await _client.call(
      contract: _contract,
      function: _getConsultationFunction,
      params: [BigInt.from(consultationId)],
    );

    return result;
  }
}
