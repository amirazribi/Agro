import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web3dart/web3dart.dart';

class AnalysisContractModel {
  // Remplacez ces valeurs par les détails du contrat déployé sur Ganache
  final String _rpcUrl = "HTTP://127.0.0.1:7545"; // L'URL du nœud RPC HTTP
  final String _wsUrl = "ws://127.0.0.1:7545/"; // L'URL du nœud WebSockets
  final String _privateKey =
      "0xd0f4cd31692cd8c80836b0003e257677a5c8d5f45653965c5c97aba389e5a094"; // Remplacez par la clé privée de votre compte Ethereum déployant le contrat

  // Remplacez cette valeur par l'adresse du contrat déployé sur Ganache
  String _contractAddress =
      "0x75Beb18c6C458aa1Ae44deBa9F2c2F1aECCb2abd"; // Remplacez par l'adresse du contrat déployé

  Web3Client? _client;
  EthereumAddress? _ownAddress;
  DeployedContract? _contract;
  ContractFunction? _saveAnalysisResultFunction;
  ContractFunction? _getAnalysisResultsCountFunction;
  ContractFunction? _getAnalysisResultFunction;
  String? _abiCode;

  AnalysisContractModel() {
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
    String abiStringFile = await rootBundle.loadString("assets/Analysis.json");

    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]) as String;

  }

  Future<void> getCredentials() async {
    final credentials = EthPrivateKey.fromHex(_privateKey);
    _ownAddress = await credentials.extractAddress();
  }

  Future<void> getDeployedContract() async {

    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode!, "Analysis"), _contractAddress as EthereumAddress);
    _saveAnalysisResultFunction = _contract!.function("saveAnalysisResult");
    _getAnalysisResultsCountFunction = _contract!.function("getAnalysisResultsCount");
    _getAnalysisResultFunction = _contract!.function("getAnalysisResult");
  }

  Future<void> saveAnalysisResult(String itemName, String result) async {
    final response = await _client!.sendTransaction(
      _ownAddress! as Credentials,
      Transaction.callContract(
        contract: _contract!,
        function: _saveAnalysisResultFunction!,
        parameters: [itemName, result],
      ),
      fetchChainIdFromNetworkId: true,
    );

    if (response != null) {
      print("Transaction hash: ${Object.hash}");
    }
  }

  Future<int> getAnalysisResultsCount() async {
    final result = await _client!.call(
      contract: _contract!,
      function: _getAnalysisResultsCountFunction!,
      params: [],
    );

    return result.first.toInt();
  }

  Future<List<AnalysisResult>> getAnalysisResults() async {
    final count = await getAnalysisResultsCount();

    final results = <AnalysisResult>[];
    for (int i = 0; i < count; i++) {
      final result = await _client!.call(
        contract: _contract!,
        function: _getAnalysisResultFunction!,
        params: [BigInt.from(i)],
      );

      final address = result[0].toString();
      final itemName = result[1].toString();
      final analysisResult = result[2].toString();

      results.add(AnalysisResult(address, itemName, analysisResult));
    }

    return results;
  }
}

class AnalysisResult {
  final String address;
  final String itemName;
  final String analysisResult;

  AnalysisResult(this.address, this.itemName, this.analysisResult);
}
