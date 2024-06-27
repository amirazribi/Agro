import 'dart:math';

import 'package:detection/models/consultation_model.dart';
import 'package:detection/ui/components/primary_button.dart';
import 'package:detection/ui/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsultationDetailController extends GetxController {
  dynamic argumentData = Get.arguments;

  ConsultationModel? consultation;

  @override
  void onInit() {
    consultation = argumentData[0]["model"];
    super.onInit();
  }

  detectDialog() {
    final temp = Random().nextInt(35);
    final hs = Random().nextInt(75);
    final ha = Random().nextInt(50);
    Get.defaultDialog(
        title: "Données de visite",
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text("La tension : "),
                  Text(
                    "$temp Pa",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.yellow.withRed(temp * 7),
                    ),
                  ),
                ],
              ),
              verticalSpaceTiny,
              Row(
                children: [
                  Text("Diabéte : "),
                  Text("$hs g/l",   style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.brown.withRed(hs * 7),
                  ),),
                ],
              ),
              verticalSpaceTiny,
              Row(
                children: [
                  Text("Battement de coeur : "),
                  Text("$ha bpm",   style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.blue.withRed(ha * 7),
                  ),),
                ],
              ),
              verticalSpaceMedium,
              Row(
                children: [
                  Text("Prix de la visite : "),
                  Text("${DateTime.now().toString().substring(0,16)}",   style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),),
                ],
              ),
            ],
          ),
        ),
        cancel: PrimaryButton(
          labelText: "Recommencer",
          onPressed: () {
            Get.back();
            detectDialog();
          },
        ),
        confirm: PrimaryButton(
          labelText: "Ok",
          onPressed: () {
            Get.back();
          },
        ));
  }
}
