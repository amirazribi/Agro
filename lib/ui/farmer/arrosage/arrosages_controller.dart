import 'package:detection/models/arrosage_model.dart';
import 'package:get/get.dart';

import '../../../models/consultation_model.dart';
import '../../../services/arrosage_service.dart';
import 'add/add_arrosage_view.dart';

class ArrosagesController extends GetxController {
  dynamic argumentData = Get.arguments;
  late ConsultationModel consultation ;
  final service = Get.find<ArrosageService>();
@override
  void onInit() {
  consultation = ConsultationModel.fromMap(argumentData[0]["model"]);
    super.onInit();
  }

  Stream<List<ArrosageModel>> getArrosages() => service.watchArrosages(consultation.id);


 navigateToAddArrosage(){
   Get.to(()=>AddArrosageView(), arguments: [{"id": consultation.id}]);
 }
}