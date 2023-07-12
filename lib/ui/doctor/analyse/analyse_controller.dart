import 'dart:io';

import 'package:detection/ui/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:get/get.dart';


class AnalyseController extends GetxController {
  List? _output;
  File? image;

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

        confirm: PrimaryButton(
          labelText: "Ok",
          onPressed: () {
            Get.back();
          },
        ));

  }
}
