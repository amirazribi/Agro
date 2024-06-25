import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detection/models/consultation_model.dart';

class ConsultationService {
  static const collectionKey = "consultations";
  final _fireStore = FirebaseFirestore.instance;

  Future createConsultation(ConsultationModel model) async {
    final doc = _fireStore.collection(collectionKey).doc();
    model.id = doc.id;

    await doc.set(model.toJson());
  }

  Future<List<ConsultationModel>> fetchConsultations() async {
    final snapshots = await _fireStore.collection(collectionKey).get();

    return snapshots.docs.map((e) => ConsultationModel.fromMap(e.data())).toList();
  }

  Stream<List<ConsultationModel>> watchConsultations() {
    return _fireStore.collection(collectionKey).snapshots().map((event) {
      List<ConsultationModel> consultations = [];
      consultations
          .addAll(event.docs.map((e) => ConsultationModel.fromMap(e.data())).toList());

      return consultations;
    });
  }

  Future removeConsultation(String? id) async {
    final doc = _fireStore.collection(collectionKey).doc(id);

    await doc.delete();
  }

  Future updateConsultation(ConsultationModel model) async {
    final doc = _fireStore.collection(collectionKey).doc(model.id);

    doc.update(model.toJson());
  }
}
