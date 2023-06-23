import 'package:detection/models/serre_model.dart';
import 'package:detection/services/arrosage_service.dart';
import 'package:detection/services/serre_service.dart';
import 'package:get/get.dart';

class FarmerController extends GetxController
    with StateMixin<List<SerreModel>> {
  final service = Get.find<SerreService>();

  @override
  onReady() {
    getSerres();
    Get.put<ArrosageService>(ArrosageService());
  }

  getSerres() async {
    change(null, status: RxStatus.loading());
    try {
      final data = await service.fetchSerres();
      if (data.isEmpty) {
        change(data, status: RxStatus.empty());
      } else {
        change(data, status: RxStatus.success());
      }
    } on Exception catch (e) {
      change(null, status: RxStatus.error("unknown error"));
    }
  }
}
