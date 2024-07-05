enum VisitesType {
  domicile,
  cabinet,
  Malchronique,
  Malnonchonique;

  String toJson() => name;

  factory VisitesType.fromJson(String json) => values.byName(json);
}