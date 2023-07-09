import 'dart:math';

import 'package:detection/models/serre_model.dart';
import 'package:detection/ui/components/primary_button.dart';
import 'package:detection/ui/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SerreDetailController extends GetxController {
  dynamic argumentData = Get.arguments;

  SerreModel? serre;

  @override
  void onInit() {
    serre = argumentData[0]["model"];
    super.onInit();
  }

  detectDialog() {
    final temp = Random().nextInt(35);
    final hs = Random().nextInt(75);
    final ha = Random().nextInt(50);
    Get.defaultDialog(
        title: "Données de Detection",
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text("La température : "),
                  Text(
                    "$temp °C",
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
                  Text("L'humidité de sol : "),
                  Text("$hs%",   style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.brown.withRed(hs * 7),
                  ),),
                ],
              ),
              verticalSpaceTiny,
              Row(
                children: [
                  Text("L'humidité de l'air : "),
                  Text("$ha %",   style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.blue.withRed(ha * 7),
                  ),),
                ],
              ),
              verticalSpaceMedium,
              Row(
                children: [
                  Text("Date de la detection : "),
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
