import 'package:detection/ui/gross/gross_controller.dart';
import 'package:detection/ui/gross/gross_order_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/controllers/auth_controller.dart';
import '../auth/login_view.dart';

class GrossView extends StatelessWidget {
  GrossView({Key? key}) : super(key: key);
  final controller = Get.put(GrossController());
  final AuthController authController = AuthController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Partie administration"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                    value: 1, child: Text("Se déconnecter"))
              ];
            },
            onSelected: (value) {
              switch (value) {
                case 1:
                  {
                    authController.signOut();
                    Get.offAll(LoginView());
                    break;
                  }
              }
            },
          )
        ],
      ),
      body: Obx(() {
        final list = controller.orders;
        print("Orders in view: $list");
        if (list.isEmpty) {
          return const Text("pas rendez-vous");
        } else {
          return ListView.builder(
              padding: const EdgeInsets.all(8.0),
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

