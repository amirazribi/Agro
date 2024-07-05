import 'package:detection/ui/infermier/rendezvous/add/add_rendezvous_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'rendezvouss_controller.dart';

class RendezvoussView extends StatelessWidget {
  RendezvoussView({Key? key}) : super(key: key);

  final controller = Get.put(RendezvoussController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${controller.consultation.name}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
            stream: controller.getRendezvouss(),
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
                              Get.to(() => AddRendezvousView(), arguments: [
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
                  child: Text("il n'ya pas de rendezvous pour cette patient "),
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: controller.navigateToAddRendezvous,
          child: const Icon(Icons.add)),
    );
  }
}
