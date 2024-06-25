import 'package:detection/models/consultation_model.dart';
import 'package:detection/services/arrosage_service.dart';
import 'package:detection/services/consultation_service.dart';
import 'package:get/get.dart';

class FarmerController extends GetxController
    with StateMixin<List<ConsultationModel>> {
  final service = Get.find<ConsultationService>();

  @override
  onReady() {
    getConsultations();
    Get.put<ArrosageService>(ArrosageService());
  }

  getConsultations() async {
    change(null, status: RxStatus.loading());
    try {
      final data = await service.fetchConsultations();
      if (data.isEmpty) {
        change(data.cast<ConsultationModel>(), status: RxStatus.empty());
      } else {
        change(data.cast<ConsultationModel>(), status: RxStatus.success());
      }
    } on Exception {
      change(null, status: RxStatus.error("unknown error"));
    }
  }
}
