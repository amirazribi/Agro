import 'package:detection/models/enum/order_status.dart';
import 'package:detection/models/order_model.dart';
import 'package:detection/services/order_service.dart';
import 'package:detection/ui/components/borderd_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/primary_button.dart';

class GrossController extends GetxController {
  final service = Get.find<OrderService>();

  RxList<OrderModel> orders = RxList();

  @override
  void onInit() {
    getOrders();
    super.onInit();
  }

  void getOrders() {
    service.watchVisitesOrders().listen((event) {
      orders.value = event;
      print("Orders updated: ${orders.length}");
    });
  }

  void onOrderClicked(OrderModel order) {
    Get.defaultDialog(
        title: "Confirmation",
        content: Column(
          children: [
            Row(children: [
              const Text("Nom med:"),
              BorderedText(order.infermierName)
            ]),
            Row(children: [
              const Text("Address :"),
              BorderedText(order.address)
            ]),
            Row(children: [
              const Text("Prix :"),
              BorderedText(order.prix.toString())
            ])
          ],
        ),
        confirm: PrimaryButton(
            labelText: "Accepter",
            onPressed: () {
              service.changeVisitesOrderStatus(OrderStatus.accepted, order.id);
              Get.back();
            }
        ),
        cancel: PrimaryButton(
            labelText: "Refuser",
            onPressed: () {
              service.changeVisitesOrderStatus(OrderStatus.rejected, order.id);
              Get.back();
            }
        )
    );
  }
}
