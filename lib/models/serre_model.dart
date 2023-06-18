class SerreModel {
   String? id;
  final String? name;
  final String? date;
  final bool isOrganic;
  final String? nature;
  final String? subNature;

  SerreModel(
      {this.id,
      this.name,
      this.nature,
      this.subNature,
      this.date,
      this.isOrganic = false});

  factory SerreModel.fromMap(Map<String, dynamic> data) {
    return SerreModel(
      id: data["id"],
      name: data["name"],
      date: data["date"],
      nature: data["nature"],
      subNature: data["subNature"],
      isOrganic: data["isOrganic"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nature": nature,
        "subNature": subNature,
        "date": date,
        "isOrganic": isOrganic,
      };
}
