import 'package:detection/models/enum/order_type.dart';
import 'package:detection/models/order_model.dart';
import 'package:detection/ui/components/utils.dart';
import 'package:flutter/material.dart';

class OrderPatientItem extends StatelessWidget {
  final OrderModel item;
  final Function() onItemClick;

  const OrderPatientItem(
      {Key? key, required this.item, required this.onItemClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: item.getColorByStatus(),
      child: ListTile(
        onTap: onItemClick,
        leading: Column(
          children: [
            Text(item.type == OrderType.plante ? " Client:" : " Grossiste:",
                style: TextStyle(fontSize: 10)),
            Text(
              item.clientName ?? "",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        title: Row(
          children: [
            Text(item.nature ?? "", style: TextStyle(fontSize: 14)),
            horizontalSpaceMedium,
          ],
        ),
        subtitle: Row(
          children: [
            const Text("date de commande :", style: TextStyle(fontSize: 10)),
            Text(item.date?.substring(0, 16) ?? "",
                style: TextStyle(fontSize: 10)),
          ],
        ),
        trailing: Column(children: [
          const Text("quantite:"),
          Text("${item.quantity}Kg"),
        ]),
      ),
    );
  }
}
