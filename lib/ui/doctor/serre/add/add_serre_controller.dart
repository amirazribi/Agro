import 'package:detection/models/serre_model.dart';
import 'package:get/get.dart';

import '../../../../services/serre_service.dart';

class AddSerreController extends GetxController {
  RxnString selectedNature = RxnString("");
  RxnString date = RxnString();
  RxnString name = RxnString("");
  RxnBool isOrganic = RxnBool();
  final service = Get.find<SerreService>();

  addSerre() async {
    return service.createSerre(SerreModel(
      id: "",
      name: name.value,
      nature: selectedNature.value,
      date: "17/06/2023",
      isOrganic: isOrganic.value ?? false
    ));
  }
}
