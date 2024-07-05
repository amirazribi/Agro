enum OrderType {

  plante,
  engrais, visites;


  String toJson() => name;

  factory OrderType.fromJson(String json) => values.byName(json);
}