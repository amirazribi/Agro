import 'package:detection/models/arrosage_model.dart';
import 'package:get/get.dart';

import '../../../models/serre_model.dart';
import '../../../services/arrosage_service.dart';
import 'add/add_arrosage_view.dart';

class ArrosagesController extends GetxController {
  dynamic argumentData = Get.arguments;
  late SerreModel serre ;
  final service = Get.find<ArrosageService>();
@override
  void onInit() {
  serre = SerreModel.fromMap(argumentData[0]["model"]);
    super.onInit();
  }

  Stream<List<ArrosageModel>> getArrosages() => service.watchArrosages(serre.id);


 navigateToAddArrosage(){
   Get.to(()=>AddArrosageView(), arguments: [{"id": serre.id}]);
 }
}