enum  UserType {
  doctor ,
  farmer ,
  client ,
  gross ;

  String toJson() => name;
  static UserType fromJson(String json) => values.byName(json);
}