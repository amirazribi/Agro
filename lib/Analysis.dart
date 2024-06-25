import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:detection/ui/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:get/get.dart';
import 'AnalysisModel.dart';

class AnalyseController extends GetxController {
  List? _output;
  File? image;
  AnalysisContractModel _contractModel = AnalysisContractModel(); // Création de l'instance

  @override
  void onInit() {
    super.onInit();
    loadModel();
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  detectImage() async {
    if (image != null) {
      var output = await Tflite.runModelOnImage(
          path: image!.path,
          numResults: 2,
          threshold: 0.6,
          imageMean: 127.5,
          imageStd: 127.5);

      _output = output;
    }

    resultDialog();
  }
  resultDialog(){
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

        confirm: ElevatedButton(
          child: Text("Ok"),
          onPressed: () {
            // Enregistrer le résultat de la détection dans la blockchain Ethereum
            saveResultToBlockchain(_output?[0]["label"]);
            Get.back();
          },
        ));
  }
  // Méthode pour enregistrer le résultat de la détection dans la blockchain Ethereum
  void saveResultToBlockchain(dynamic result) {
    if (result != null) {
      String itemName = "Image Detection";
      String finalResult;

      if (result is String) {
        finalResult = result;
      } else if (result is Map<String, dynamic>) {
        finalResult = result["label"].toString();
      } else {
        // Si le type n'est pas String ni Map, vous pouvez choisir une valeur par défaut ou gérer l'erreur selon votre besoin.
        finalResult = "Unknown Result";
      }

      // Appelez la méthode saveAnalysisResult du modèle de contrat pour envoyer la transaction Ethereum
      _contractModel.saveAnalysisResult(itemName, finalResult);
    }
  }

}
