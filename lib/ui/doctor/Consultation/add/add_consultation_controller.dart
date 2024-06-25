import 'package:detection/models/consultation_model.dart';
import 'package:get/get.dart';

import '../../../../services/consultation_service.dart';

class AddConsultationController extends GetxController {
  RxnString selectedNature = RxnString("");
  RxnString date = RxnString();
  RxnString name = RxnString("");
  RxnBool isOrganic = RxnBool();
  final service = Get.find<ConsultationService>();

  addConsultation() async {
    return service.createConsultation(ConsultationModel(
      id: "",
      name: name.value,
      nature: selectedNature.value,
      date: "17/06/2023",
      isOrganic: isOrganic.value ?? false
    ));
  }
}
