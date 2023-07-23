enum OrderType {

  plante,
  engrais;


  String toJson() => name;

  factory OrderType.fromJson(String json) => values.byName(json);
}