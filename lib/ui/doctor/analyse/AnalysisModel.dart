import 'dart:convert';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart';

class AnalysisModel {
  // Connect to Ethereum Node:
  final String rpcUrl =
      'HTTP://127.0.0.1:7545'; // Ethereum provider URL (like Ganache).
  late Web3Client _client; // Use the `late` keyword to indicate late initialization.

  Uint8List stringToBytes(String input) {
    final encoded = utf8.encode(input);
    return Uint8List.fromList(encoded);
  }

  AnalysisModel() {
    // Initialize the Web3Client instance in the constructor.
    _client = Web3Client(rpcUrl, Client());
  }

  Future<DeployedContract> loadContractABI() async {
    try {
      final contractABI = await rootBundle.loadString("assets/Analysis.json");
      final contractAbiJson = jsonDecode(contractABI) as Map<String, dynamic>;

      final contractAddress = EthereumAddress.fromHex(
          '0x87811c225E256Fa8D1A7E84fC01AC26D1de1519e'); // The address of the deployed contract

      final contractAbi = jsonEncode(contractAbiJson['abi']); // Convertir la liste ABI en chaîne JSON

      return DeployedContract(
        ContractAbi.fromJson(contractAbi, "Analysis"),
        contractAddress,
      );
    } catch (e) {
      print("Error loading contract ABI: $e");
      rethrow;
    }
  }



  Future<void> saveAnalysisResult(String result) async {
    try {
      final contract = await loadContractABI();
      final function = contract.function("saveAnalysisResult");
      const String privateKey =
          "0xd0f4cd31692cd8c80836b0003e257677a5c8d5f45653965c5c97aba389e5a094";
      final credentials = EthPrivateKey.fromHex(privateKey);

      final transaction = Transaction.callContract(
        contract: contract,
        function: function,
        parameters: [result], // Envoyer le résultat en tant que chaîne de caractères
      );

      // Envoyer la transaction et attendre le résultat
      final transactionHash = await _client.sendTransaction(
        credentials,
        transaction,
        chainId: 5777,
      );

      if (transactionHash != null) {
        print("Transaction sent: $transactionHash");
      } else {
        print("Transaction failed");
      }
    } catch (e, stackTrace) {
      print("Error sending transaction: $e");
      print("Stack trace: $stackTrace");
    }
  }

}

// Function to get the analysis results count
// Future<int> getAnalysisResultsCount() async {
//   final contract = await loadContractABI();
//   final function = contract.function("getAnalysisResultsCount");
//   final result =
//       await _client.call(contract: contract, function: function, params: []);
//   return result.first.toInt();
// }

