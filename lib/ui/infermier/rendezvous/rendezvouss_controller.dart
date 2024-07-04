import 'package:detection/models/rendezvous_model.dart';
import 'package:get/get.dart';

import '../../../models/consultation_model.dart';
import '../../../services/rendezvous_service.dart';
import 'add/add_rendezvous_view.dart';

class RendezvoussController extends GetxController {
  dynamic argumentData = Get.arguments;
  late ConsultationModel consultation ;
  final service = Get.find<RendezvousService>();
@override
  void onInit() {
  consultation = ConsultationModel.fromMap(argumentData[0]["model"]);
    super.onInit();
  }

  Stream<List<RendezvousModel>> getRendezvouss() => service.watchRendezvouss(consultation.id);


 navigateToAddRendezvous(){
   Get.to(()=>AddRendezvousView(), arguments: [{"id": consultation.id}]);
 }
}