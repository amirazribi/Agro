import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:detection/models/order_model.dart';
import 'package:detection/services/order_service.dart';
import 'package:detection/ui/components/borderd_text.dart';
import 'package:detection/ui/components/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/enum/order_status.dart';
import '../../../models/enum/order_type.dart';

class FarmOrdersController extends GetxController {
  final service = Get.find<OrderService>();

  RxList<OrderModel> orders = RxList();
  RxInt counter = 0.obs;

  @override
  onInit() {
    getOrders();
    super.onInit();
  }

  getOrders() {
    service.watchOrders().listen((event) {
      orders.value = event.where((element) =>
      element.farmerId == FirebaseAuth.instance.currentUser?.uid &&
          element.type == OrderType.plante).toList();
      counter.value = event.where((element) =>
      element.farmerId == FirebaseAuth.instance.currentUser?.uid &&
          element.type == OrderType.engrais &&
          element.status != OrderStatus.pending).length;
    });
  }


onOrderClicked(OrderModel order) {
  Get.defaultDialog(
      title: "Confirmation",
      content: Column(
        children: [
          Row(children: [
            const Text("Nom :"),
            BorderedText(order.clientName)
          ]),
          Row(children: [
            const Text("Address :"),
            BorderedText(order.address)
          ]),
          Row(children: [
            const Text("Quantité :"),
            BorderedText(order.quantity.toString())
          ])
        ],
      ),
      confirm: PrimaryButton(
          labelText: "Accepter",
          onPressed: () {
            service.changeOrderStatus(OrderStatus.accepted, order.id);
            Get.back();
          }),
      cancel: PrimaryButton(
          labelText: "Refuser",
          onPressed: () {
            service.changeOrderStatus(OrderStatus.rejected, order.id);
            Get.back();
          }));
}}
