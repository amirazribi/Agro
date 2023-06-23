import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detection/models/arrosage_model.dart';

class ArrosageService {
  static const collectionKey = "arrosages";
  final _fireStore = FirebaseFirestore.instance;

  Future createArrosage(ArrosageModel arrosageModel) async {
    final doc = _fireStore.collection(collectionKey).doc();
    arrosageModel.id = doc.id;

    await doc.set(arrosageModel.toJson());
  }

  Future updateArrosage(ArrosageModel arrosageModel) async {
    final doc = _fireStore.collection(collectionKey).doc(arrosageModel.id);

    await doc.update(arrosageModel.toJson());
  }

  Future deleteArrosage(String? arrosageId) async {
    final doc = _fireStore.collection(collectionKey).doc(arrosageId);

    await doc.delete();
  }

  Stream<List<ArrosageModel>> watchArrosages(String? serreId) {
    return _fireStore
        .collection(collectionKey)
        .where("serre_id", isEqualTo: serreId)
        .snapshots()
        .map((event) {
      List<ArrosageModel> data = [];
      data = event.docs.map((e) => ArrosageModel.fromMap(e.data())).toList();
      return data;
    });
  }
}
