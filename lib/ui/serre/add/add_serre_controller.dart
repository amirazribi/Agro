import 'package:detection/models/serre_model.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../services/serre_service.dart';

class AddSerreController extends GetxController {
  List<String> natures = ['Fruits', 'Légumes', 'Plantes aromatiques'];
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
