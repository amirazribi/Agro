import 'package:detection/ui/infermier/orders/engrais/engrai_order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EngraisOrderView extends StatelessWidget {
  EngraisOrderView({Key? key}) : super(key: key);
  final controller = Get.put(EngraisOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Commandes des engrais"),
      ),
      body: controller.obx(
          (data) => ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return OrderInfermierItem(
                    item: data![index],
                    onItemClick: () {},
                  );
                },
              ),
          onLoading: const Center(child: CircularProgressIndicator()),
          onEmpty: const Text("no data found"),
          onError: (error) => Text(error ?? "unknown error")),
    );
  }
}
