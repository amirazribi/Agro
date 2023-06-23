import 'package:detection/services/serre_service.dart';
import 'package:get/get.dart';

import '../../../models/serre_model.dart';

class SerreController extends GetxController with StateMixin<List<SerreModel>> {
  final service = Get.find<SerreService>();

  final serres = <SerreModel>[].obs;

  @override
  onReady() {
    serres.bindStream(service.watchSerres());
  }


  removeSerre(String? id) async {
    service.removeSerre(id);
  }
}
