import 'package:detection/ui/farmer/arrosage/add/add_arrosage_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'arrosages_controller.dart';

class ArrosagesView extends StatelessWidget {
  ArrosagesView({Key? key}) : super(key: key);

  final controller = Get.put(ArrosagesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${controller.consultation.name}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
            stream: controller.getArrosages(),
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
                      return Card(
                        elevation: 4,
                        shadowColor: Colors.white60,
                        child: ListTile(
                          title: Text("${list[index].name}"),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Get.to(() => AddArrosageView(), arguments: [
                                {
                                  "id": controller.consultation.id,
                                  "model": list[index]
                                }
                              ]);
                            },
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: Text("il n'ya pas des arrosages pour cette serre"),
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: controller.navigateToAddArrosage,
          child: const Icon(Icons.add)),
    );
  }
}
