import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web3dart/web3dart.dart';

class ConsultationModel {
  final String _rpcUrl = "http://127.0.0.1:7545"; // Ganache RPC URL
  final String _wsUrl = "ws://127.0.0.1:7545/"; // Ganache WebSocket URL
  final String _privateKey = "0xd0f4cd31692cd8c80836b0003e257677a5c8d5f45653965c5c97aba389e5a094"; // Your private key

  // Replace with your deployed contract address
  String _contractAddress = "0x5f63d98a7FB46932fFea6d737C99F3D62C8F6489";

  Web3Client? _client;
  EthereumAddress? _ownAddress;
  DeployedContract? _contract;
  ContractFunction? _confirmConsultationFunction;
  ContractFunction? _getConsultationFunction;
  String? _abiCode;

  ConsultationModel() {
    initiateSetup();
  }

  Future<void> initiateSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile = await rootBundle.loadString("assets/contracts/Consultation.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress = jsonAbi["networks"]["5777"]["address"];
  }

  Future<void> getCredentials() async {
    final credentials = EthPrivateKey.fromHex(_privateKey);
    _ownAddress = await credentials.extractAddress();
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode!, "Consultation"), EthereumAddress.fromHex(_contractAddress));
    _confirmConsultationFunction = _contract!.function("confirmConsultation");
    _getConsultationFunction = _contract!.function("getConsultation");
  }

  Future<void> confirmConsultation(String medicName, String patientAddress, int price) async {
    final credentials = EthPrivateKey.fromHex(_privateKey);
    await _client!.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: _contract!,
        function: _confirmConsultationFunction!,
        parameters: [medicName, patientAddress, BigInt.from(price)],
      ),
      fetchChainIdFromNetworkId: true,
    );
  }

  Future<Map<String, dynamic>> getConsultation(int consultationId) async {
    final result = await _client!.call(
      contract: _contract!,
      function: _getConsultationFunction!,
      params: [BigInt.from(consultationId)],
    );
    return {
      "medicName": result[0] as String,
      "patientAddress": result[1] as String,
      "price": (result[2] as BigInt).toInt(),
    };
  }
}
