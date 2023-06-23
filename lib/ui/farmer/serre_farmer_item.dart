import 'package:detection/models/serre_model.dart';
import 'package:flutter/material.dart';

import '../components/utils.dart';

class SerreFarmerItem extends StatelessWidget {
  final SerreModel serre;
  final Function() onItemClick;

  const SerreFarmerItem(
      {Key? key, required this.serre, required this.onItemClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white60,
      child: ListTile(
        onTap: onItemClick,
        leading: Text(
          serre.name ?? "",
          style: TextStyle(fontSize: 18),
        ),
        title: Row(
          children: [
            Text(serre.nature ?? "", style: TextStyle(fontSize: 14)),
            horizontalSpaceMedium,
            Text(serre.subNature ?? ""),
          ],
        ),
        subtitle: Row(
          children: [
            const Text("date de plantation :", style: TextStyle(fontSize: 12)),
            Text(serre.date ?? "", style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
