import 'package:detection/models/order_model.dart';
import 'package:detection/ui/components/utils.dart';
import 'package:flutter/material.dart';

class OrderGrossItem extends StatelessWidget {
  final OrderModel item;
  final Function() onItemClick;

  const OrderGrossItem({Key? key, required this.item, required this.onItemClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white60,
      child: ListTile(
        onTap: onItemClick,
        leading: Column(
          children: [
            const Text("Infermier:", style: TextStyle(fontSize: 10)),
            Text(item.infermierName ?? "", style: const TextStyle(fontSize: 18)),
          ],
        ),
        title: Row(
          children: [
            const Text("Type visites:", style: TextStyle(fontSize: 12)),
            Text(item.visitesType?.name ?? "", style: const TextStyle(fontSize: 14)),
          ],
        ),
        subtitle: Row(
          children: [
            const Text("Date de consultation:", style: TextStyle(fontSize: 12)),
            Text(item.date?.substring(0, 16) ?? "", style: const TextStyle(fontSize: 12)),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Prix:", style: TextStyle(fontSize: 10)),
            Text("${item.prix}Dt"),
          ],
        ),
      ),
    );
  }
}
