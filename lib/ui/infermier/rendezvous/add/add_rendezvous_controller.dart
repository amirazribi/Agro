import 'package:detection/models/rendezvous_model.dart';
import 'package:detection/services/rendezvous_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AddRendezvousController extends GetxController {
  dynamic argumentData = Get.arguments;
  late String consultationId;
  RendezvousModel? model;

  @override
  void onInit() {
    consultationId = argumentData[0]["id"];
    model = argumentData[0]["model"];
    super.onInit();
  }

  String? name;

  String? date;

  String? duration;

  final service = Get.find<RendezvousService>();

  addRendezvous() async {
    await service.createRendezvous(RendezvousModel(
        consultationId: consultationId,
        name: name,
        date: date,
        duration: duration,
        infermierId: FirebaseAuth.instance.currentUser?.uid));
  }

  updateRendezvous()async {
    await service.updateRendezvous(RendezvousModel(
      id: model?.id,
        consultationId: consultationId,
        name: name ?? model?.name,
        date: date ?? model?.date,
        duration: duration ?? model?.duration,
        infermierId: FirebaseAuth.instance.currentUser?.uid
    ));
  }
}
