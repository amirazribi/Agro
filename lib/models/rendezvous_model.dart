class RendezvousModel {
   String? id;

  final String? consultationId;
final String? name;
  final String? date;
  final String? duration;

  final String? infermierId;

  RendezvousModel({
    this.id,
    this.consultationId,
    this.name,
    this.date,
    this.duration,
    this.infermierId,
  });

  factory RendezvousModel.fromMap(Map<String, dynamic> data) {
    return RendezvousModel(
        id: data["id"],
        consultationId: data["consultation_id"],
        name: data["name"],
        date: data["date"],
        duration: data["duration"],
        infermierId: data["infermier_id"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "consultation_id": consultationId,
      "name":name,
      "date": date,
      "duration": duration,
      "infermier_id": infermierId
    };
  }
}
