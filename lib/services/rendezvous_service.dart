import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detection/models/rendezvous_model.dart';

class RendezvousService {
  static const collectionKey = "rendezvouss";
  final _fireStore = FirebaseFirestore.instance;

  Future createRendezvous(RendezvousModel rendezvousModel) async {
    final doc = _fireStore.collection(collectionKey).doc();
    rendezvousModel.id = doc.id;

    await doc.set(rendezvousModel.toJson());
  }

  Future updateRendezvous(RendezvousModel rendezvousModel) async {
    final doc = _fireStore.collection(collectionKey).doc(rendezvousModel.id);

    await doc.update(rendezvousModel.toJson());
  }

  Future deleteRendezvous(String? rendezvousId) async {
    final doc = _fireStore.collection(collectionKey).doc(rendezvousId);

    await doc.delete();
  }

  Stream<List<RendezvousModel>> watchRendezvouss(String? serreId) {
    return _fireStore
        .collection(collectionKey)
        .where("serre_id", isEqualTo: serreId)
        .snapshots()
        .map((event) {
      List<RendezvousModel> data = [];
      data = event.docs.map((e) => RendezvousModel.fromMap(e.data())).toList();
      return data;
    });
  }
}
