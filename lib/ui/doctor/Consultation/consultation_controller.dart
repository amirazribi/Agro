import 'package:detection/services/consultation_service.dart';
import 'package:get/get.dart';

import '../../../models/consultation_model.dart';

class ConsultationController extends GetxController with StateMixin<List<ConsultationModel>> {
  final service = Get.find<ConsultationService>();

  final consultations = <ConsultationModel>[].obs;

  @override
  onReady() {
    consultations.bindStream(service.watchConsultations());
  }


  removeConsultation(String? id) async {
    service.removeConsultation(id);
  }
}
