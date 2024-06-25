class AnalyseResult {
  final String? id; // Identifiant du résultat d'analyse (facultatif).
  final String? label; // État ou label du résultat d'analyse.
  final DateTime timestamp; // Horodatage du résultat d'analyse.

  AnalyseResult({
    this.id,
    this.label,
    required this.timestamp,
  });

  factory AnalyseResult.fromMap(Map<String, dynamic> data, String id) {
    return AnalyseResult(
      id: id,
      label: data["label"],
      timestamp: data["timestamp"].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "label": label,
      "timestamp": timestamp,
    };
  }
}
