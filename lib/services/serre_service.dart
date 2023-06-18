import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detection/models/serre_model.dart';

class SerreService {
  static const collectionKey = "serres";
  final _fireStore = FirebaseFirestore.instance;

  Future createSerre(SerreModel model) async {
    final doc = _fireStore.collection(collectionKey).doc();
    model.id = doc.id;

    await doc.set(model.toJson());
  }

  Future<List<SerreModel>> fetchSerres() async {
    final snapshots = await _fireStore.collection(collectionKey).get();

    return snapshots.docs.map((e) => SerreModel.fromMap(e.data())).toList();
  }

  Stream<List<SerreModel>> watchSerres() {
    return _fireStore.collection(collectionKey).snapshots().map((event) {
      List<SerreModel> serres = [];
      serres
          .addAll(event.docs.map((e) => SerreModel.fromMap(e.data())).toList());

      return serres;
    });
  }

  Future removeSerre(String? id) async {
    final doc = _fireStore.collection(collectionKey).doc(id);

    await doc.delete();
  }

  Future updateSerre(SerreModel model) async {
    final doc = _fireStore.collection(collectionKey).doc(model.id);

    doc.update(model.toJson());
  }
}
