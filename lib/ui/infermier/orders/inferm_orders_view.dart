import 'package:detection/ui/components/primary_button.dart';
import 'package:detection/ui/components/utils.dart';
import 'package:detection/ui/infermier/orders/engrais/add_engrais_view.dart';
import 'package:detection/ui/infermier/orders/engrais/engrais_order_view.dart';
import 'package:detection/ui/infermier/orders/inferm_orders_controller.dart';
import 'package:detection/ui/infermier/orders/order_inferm_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfermOrdersView extends StatelessWidget {
  InfermOrdersView({Key? key}) : super(key: key);
  final controller = Get.put(InfermOrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Liste des Rendez-vous"),
            centerTitle: true,
            actions: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Badge(
                  label: Obx(() => Text(controller.counter.toString())),
                  child: IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {
                      Get.to(()=>EngraisOrderView());
                    },
                  ),
                ),
              )
            ]),
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                final list = controller.orders;
                return ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return OrderInfermierItem(
                        item: list[index],
                        onItemClick: () {
                          controller.onOrderClicked(list[index]);
                        },
                      );
                    });
              }),
            ),
            PrimaryButton(
                labelText: "Passer Rendez-vous ",
                onPressed: () {
                  Get.to(() => AddEngraisView());
                }),
            verticalSpaceMedium,
          ],
        ));
  }
}
