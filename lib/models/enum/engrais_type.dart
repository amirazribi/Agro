enum EngraisType {
  chimique,
  bio,
  organique,
  nonOrganique;

  String toJson() => name;

  factory EngraisType.fromJson(String json) => values.byName(json);
}