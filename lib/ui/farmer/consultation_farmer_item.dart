import 'package:detection/models/consultation_model.dart';
import 'package:flutter/material.dart';

import '../components/utils.dart';

class ConsultationFarmerItem extends StatelessWidget {
  final ConsultationModel consultation;
  final Function() onItemClick;

  const ConsultationFarmerItem(
      {Key? key, required this.consultation, required this.onItemClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white60,
      child: ListTile(
        onTap: onItemClick,
        leading: Text(
          consultation.name ?? "",
          style: TextStyle(fontSize: 18),
        ),
        title: Row(
          children: [
            Text(consultation.nature ?? "", style: TextStyle(fontSize: 14)),
            horizontalSpaceMedium,
            Text(consultation.subNature ?? ""),
          ],
        ),
        subtitle: Row(
          children: [
            const Text("date de consultation :", style: TextStyle(fontSize: 12)),
            Text(consultation.date ?? "", style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
