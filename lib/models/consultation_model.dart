class ConsultationModel {
   String? id;
  final String? name;
  final String? date;
  final bool isOrganic;
  final String? nature;
  final String? subNature;
  final String? doctorId;

  ConsultationModel({
    this.id,
    this.name,
    this.nature,
    this.subNature,
    this.date,
    this.isOrganic = false,
    this.doctorId, required ischronique,
  });

  factory ConsultationModel.fromMap(Map<String, dynamic> data) {
    return ConsultationModel(
      id: data["id"],
      name: data["name"],
      date: data["date"],
      nature: data["nature"],
      subNature: data["subNature"],
      ischronique: data["ischronique"] ?? false,
      doctorId: data["doctorId"],
    );
  }

  get ischronique => null;

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "nature": nature,
        "subNature": subNature,
        "date": date,
        "ischronique": ischronique,
        "doctorId": doctorId,
      };
}
