import 'package:detection/models/enum/visites_type.dart';
import 'package:flutter/material.dart';

import 'enum/order_status.dart';
import 'enum/order_type.dart';

class OrderModel {
  String? id;
  final String? address;
  final String? date;
  final int prix;
  final String? nature;
  final String? clientName;
  final String? clientId;
  final String? infermierName;
  final String? infermierId;
  OrderStatus status;
  OrderType type;
  final VisitesType? visitesType;

  OrderModel({
    this.id,
    this.address,
    this.date,
    this.prix = 0,
    this.nature,
    this.clientName,
    this.clientId,
    this.infermierName,
    this.infermierId,
    this.status = OrderStatus.pending,
    this.type = OrderType.plante,
    this.visitesType,
  });

  factory OrderModel.fromMap(Map<String, dynamic> data) {
    return OrderModel(
      id: data["id"],
      address: data["address"],
      date: data["date"],
      nature: data["nature"],
      prix: data["prix"] ?? 0,
      clientId: data["clientId"],
      clientName: data["clientName"],
      infermierName: data["infermierName"],
      infermierId: data["infermierId"],
      status: OrderStatus.fromJson(data["status"]),
      type: OrderType.fromJson(data["type"]),
      visitesType: data["visitesType"] != null
          ? VisitesType.fromJson(data["visitesType"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "nature": nature,
    "date": date,
    "prix": prix,
    "clientId": clientId,
    "infermierId": infermierId,
    "clientName": clientName,
    "infermierName": infermierName,
    "status": status.toJson(),
    "type": type.toJson(),
    "visitesType": visitesType?.toJson(),
  };

  Color getColorByStatus() {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange.withOpacity(0.5);
      case OrderStatus.accepted:
        return Colors.green.withOpacity(0.5);
      case OrderStatus.rejected:
        return Colors.red.withOpacity(0.5);
      default:
        return Colors.grey.withOpacity(0.5);
    }
  }
}
