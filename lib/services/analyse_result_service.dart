import 'package:cloud_firestore/cloud_firestore.dart';

class AnalyseResultService {
  final CollectionReference _resultsCollection =
  FirebaseFirestore.instance.collection('results');

  Future<void> saveAnalysisResult(String label) async {
    try {
      await _resultsCollection.add({
        'label': label,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Résultat enregistré dans Firebase : $label');
    } catch (e) {
      print('Erreur lors de l\'enregistrement dans Firebase : $e');
    }
  }



}
