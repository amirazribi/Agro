import 'package:detection/ui/components/primary_button.dart';
import 'package:detection/ui/components/utils.dart';
import 'package:detection/ui/farmer/orders/engrais/add_engrais_view.dart';
import 'package:detection/ui/farmer/orders/engrais/engrais_order_view.dart';
import 'package:detection/ui/farmer/orders/farm_orders_controller.dart';
import 'package:detection/ui/farmer/orders/order_farm_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FarmOrdersView extends StatelessWidget {
  FarmOrdersView({Key? key}) : super(key: key);
  final controller = Get.put(FarmOrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("List des commandes"),
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
                      return OrderFarmerItem(
                        item: list[index],
                        onItemClick: () {
                          controller.onOrderClicked(list[index]);
                        },
                      );
                    });
              }),
            ),
            PrimaryButton(
                labelText: "Passer Commande  Engrais ",
                onPressed: () {
                  Get.to(() => AddEngraisView());
                }),
            verticalSpaceMedium,
          ],
        ));
  }
}
