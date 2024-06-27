class ArrosageModel {
   String? id;

  final String? consultationId;
final String? name;
  final String? date;
  final String? duration;

  final String? farmerId;

  ArrosageModel({
    this.id,
    this.consultationId,
    this.name,
    this.date,
    this.duration,
    this.farmerId,
  });

  factory ArrosageModel.fromMap(Map<String, dynamic> data) {
    return ArrosageModel(
        id: data["id"],
        consultationId: data["consultation_id"],
        name: data["name"],
        date: data["date"],
        duration: data["duration"],
        farmerId: data["farmer_id"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "consultation_id": consultationId,
      "name":name,
      "date": date,
      "duration": duration,
      "farmer_id": farmerId
    };
  }
}
