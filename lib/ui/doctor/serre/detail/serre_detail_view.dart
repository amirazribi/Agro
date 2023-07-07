import 'package:detection/ui/components/primary_button.dart';
import 'package:detection/ui/components/utils.dart';
import 'package:detection/ui/doctor/serre/detail/serre_detail_controller.dart';
import 'package:detection/utlis/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SerreDetailView extends StatelessWidget {
  SerreDetailView({Key? key}) : super(key: key);
  final controller = Get.put(SerreDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Details du Serre"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(controller.serre?.nature ?? "",
                  style: TextStyle(fontSize: 20)),
              buildLeading(),
              horizontalSpaceNormal,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("date de plantation :",
                      style: TextStyle(fontSize: 16)),
                  Text(controller.serre?.date ?? "",
                      style: TextStyle(fontSize: 16)),
                ],
              ),
              verticalSpaceMedium,
              buildTrailing(),
              verticalSpaceSmall,
              PrimaryButton(
                  labelText: "Detecter",
                  onPressed: () {
                    controller.detectDialog();
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLeading() {
    if (controller.serre?.nature?.toLowerCase() ==
        Constants.tomato.toLowerCase()) {
      return Image.asset("assets/tomato.jpg");
    } else if (controller.serre?.nature?.toLowerCase() ==
        Constants.potato.toLowerCase()) {
      return Image.asset("assets/potato.jpg");
    } else {
      return Text(
        controller.serre?.name ?? "",
        style: TextStyle(fontSize: 18),
      );
    }
  }

  Widget buildTrailing() {
    if (controller.serre?.isOrganic ?? false) {
      return Text(
        "Cette plante est organique",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      );
    }
    return Text(
      "Cette plante n'est pas organique",
      style: TextStyle(fontSize: 18),
    );
  }
}
