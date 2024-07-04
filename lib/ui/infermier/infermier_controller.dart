import 'package:detection/models/consultation_model.dart';
import 'package:detection/services/rendezvous_service.dart';
import 'package:detection/services/consultation_service.dart';
import 'package:get/get.dart';

class InfermierController extends GetxController
    with StateMixin<List<ConsultationModel>> {
  final service = Get.find<ConsultationService>();

  @override
  onReady() {
    getConsultations();
    Get.put<RendezvousService>(RendezvousService());
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
