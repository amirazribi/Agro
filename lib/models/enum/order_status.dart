enum OrderStatus {
  pending,
  accepted,
  rejected;

  String toJson() => name;

  factory OrderStatus.fromJson(String json) => values.byName(json);
}
