import 'package:detection/models/arrosage_model.dart';
import 'package:detection/services/arrosage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AddArrosageController extends GetxController {
  dynamic argumentData = Get.arguments;
  late String serreId;
  ArrosageModel? model;

  @override
  void onInit() {
    serreId = argumentData[0]["id"];
    model = argumentData[0]["model"];
    super.onInit();
  }

  String? name;

  String? date;

  String? duration;

  final service = Get.find<ArrosageService>();

  addArrosage() async {
    await service.createArrosage(ArrosageModel(
        serreId: serreId,
        name: name,
        date: date,
        duration: duration,
        farmerId: FirebaseAuth.instance.currentUser?.uid));
  }

  updateArrosage()async {
    await service.updateArrosage(ArrosageModel(
      id: model?.id,
        serreId: serreId,
        name: name ?? model?.name,
        date: date ?? model?.date,
        duration: duration ?? model?.duration,
        farmerId: FirebaseAuth.instance.currentUser?.uid
    ));
  }
}
