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
        title: "Resultat de Detection",
        content: Column(
          children: [
            const Text("La température :"),
            Text("$temp ²C"),
            Text("l'humidité de sol :"),
            Text("$hs%"),
            Text("l'humidité de l'air :"),
            Text("$ha %"),
            verticalSpaceMedium,
            verticalSpaceTiny,
          ],
        ),
        cancel: PrimaryButton(
          labelText: "Refaire",
          onPressed: () {
           detectDialog();
          },
        ),
        confirm: PrimaryButton(
          labelText: "Ok",
          onPressed: () {},
        ));
  }
}
