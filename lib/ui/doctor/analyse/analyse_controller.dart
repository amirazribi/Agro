import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detection/ui/components/primary_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:get/get.dart';
import 'AnalysisModel.dart';

class AnalyseController extends GetxController {
  List? _output;
  File? image;
  final AnalysisModel analysisModel = AnalysisModel();

  @override
  void onInit() {
    super.onInit();
    loadModel();
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
    );
  }

  detectImage() async {
    if (image != null) {
      var output = await Tflite.runModelOnImage(
        path: image!.path,
        numResults: 2,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      _output = output;
    }
    resultDialog();
    // Enregistrer le résultat dans Firebase et dans la blockchain Ethereum
    if (_output != null && _output!.isNotEmpty) {
      String result = _output![0]["label"].toString();
      await saveAnalysisResultToFirebase(result);
      await saveAnalysisResultToEthereum(result);
    }
  }

  resultDialog() {
    Get.defaultDialog(
      title: "Resultat",
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text("etat : "),
                Flexible(
                  child: Text(
                    "${_output?[0]["label"]}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      confirm: PrimaryButton(
        labelText: "Ok",
        onPressed: () {
          Get.back();
        },
      ),
    );
  }

  // Fonction pour enregistrer le résultat dans la blockchain Ethereum via AnalysisModel
  saveAnalysisResultToEthereum(String result) async {
    print("Result to be sent to Ethereum: $result");

    // Convertir la valeur en chaîne de caractères avant de l'envoyer à la blockchain
    String resultAsString = result;
    await analysisModel.saveAnalysisResult(resultAsString);
  }

  @override
  void onClose() {
    Tflite.close();
    super.onClose();
  }
}

Future<void> saveAnalysisResultToFirebase(String result) async {
  try {
    // Assurez-vous que Firebase est correctement initialisé avant d'enregistrer les données

    // Récupérer une référence à la collection "results" dans Firebase Firestore
    CollectionReference resultsRef =
    FirebaseFirestore.instance.collection('results');

    // Ajouter le résultat à la collection avec la date et l'heure actuelles
    await resultsRef.add({
      'result': result,
      'timestamp': FieldValue.serverTimestamp(),
    });

    print('Résultat enregistré dans Firebase : $result');
  } catch (e) {
    print('Erreur lors de l\'enregistrement dans Firebase : $e');
  }
}
