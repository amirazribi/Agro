import 'package:detection/ui/gross/gross_controller.dart';
import 'package:detection/ui/gross/gross_order_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GrossView extends StatelessWidget {
  GrossView({Key? key}) : super(key: key);
  final controller = Get.put(GrossController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Partie Gross"),
      ),
      body: Obx(() {
        final list = controller.orders;
        if (list.isEmpty) {
          return Text("pas de commandes engrais");
        } else {
          return ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return OrderGrossItem(
                  item: list[index],
                  onItemClick: () {
                    controller.onOrderClicked(list[index]);
                  },
                );
              });
        }
      }),
    );
  }
}
