enum OrderType {

  plante,
  consultations,  visites;


  String toJson() => name;

  factory OrderType.fromJson(String json) => values.byName(json);
}