import 'package:detection/services/serre_service.dart';
import 'package:get/get.dart';

import '../../models/serre_model.dart';

class SerreController extends GetxController with StateMixin<List<SerreModel>> {
  final service = Get.find<SerreService>();

  final serres = <SerreModel>[].obs;

  @override
  onReady() {
    serres.bindStream(service.watchSerres());
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

  removeSerre(String? id) async {
    service.removeSerre(id);
    refresh();
  }
}
