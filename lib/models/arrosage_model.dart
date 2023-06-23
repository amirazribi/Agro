class ArrosageModel {
   String? id;

  final String? serreId;
final String? name;
  final String? date;
  final String? duration;

  final String? farmerId;

  ArrosageModel({
    this.id,
    this.serreId,
    this.name,
    this.date,
    this.duration,
    this.farmerId,
  });

  factory ArrosageModel.fromMap(Map<String, dynamic> data) {
    return ArrosageModel(
        id: data["id"],
        serreId: data["serre_id"],
        name: data["name"],
        date: data["date"],
        duration: data["duration"],
        farmerId: data["farmer_id"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "serre_id": serreId,
      "name":name,
      "date": date,
      "duration": duration,
      "farmer_id": farmerId
    };
  }
}
