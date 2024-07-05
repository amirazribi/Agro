import 'package:detection/ui/auth/controllers/auth_controller.dart';
import 'package:detection/ui/auth/login_view.dart';
import 'package:detection/ui/client/order_client_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'client_controller.dart';

class ClientView extends StatelessWidget {
  ClientView({Key? key}) : super(key: key);
  final ClientController controller = Get.put(ClientController());
  final AuthController authController = AuthController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Partie Patient"),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
            stream: controller.getOrders(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData &&
                  (snapshot.data?.isNotEmpty ?? false)) {
                final list = snapshot.data!;
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return OrderClientItem(
                          item: list[index], onItemClick: () {});
                    });
              } else {
                return const Center(
                    child: Text(
                  "il n'ya pas des rendezvous .\n vous pouvez ajouter une endezvous en cliquant sur le bouton +",
                  textAlign: TextAlign.center,
                ));
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: controller.navigateToAddOrder,
          child: const Icon(Icons.add)),
    );
  }
}
