class SerreModel {
   String? id;
  final String? name;
  final String? date;
  final bool isOrganic;
  final String? nature;
  final String? subNature;
  final String? doctorId;

  SerreModel({
    this.id,
    this.name,
    this.nature,
    this.subNature,
    this.date,
    this.isOrganic = false,
    this.doctorId,
  });

  factory SerreModel.fromMap(Map<String, dynamic> data) {
    return SerreModel(
      id: data["id"],
      name: data["name"],
      date: data["date"],
      nature: data["nature"],
      subNature: data["subNature"],
      isOrganic: data["isOrganic"] ?? false,
      doctorId: data["doctorId"],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "nature": nature,
        "subNature": subNature,
        "date": date,
        "isOrganic": isOrganic,
        "doctorId": doctorId,
      };
}
