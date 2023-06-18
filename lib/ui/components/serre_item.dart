import 'package:detection/models/serre_model.dart';
import 'package:detection/ui/components/utils.dart';
import 'package:flutter/material.dart';

class SerreItem extends StatelessWidget {
  final SerreModel serre;
  final Function(String?) onRemoveClicked;

   SerreItem({Key? key, required this.serre ,required this.onRemoveClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white60,
      child: ListTile(
        leading: Text(serre.name ?? "" ,style: TextStyle(fontSize: 18),),
        title: Row(

          children: [
            Text(serre.nature ?? "",style: TextStyle(fontSize: 14)),
            horizontalSpaceMedium,
            Text(serre.subNature ?? ""),
          ],
        ),
        subtitle: Row(
          children: [
            const Text("date de plantation :" ,style: TextStyle(fontSize: 12)),
            Text(serre.date ?? "" ,style: TextStyle(fontSize: 12)),
          ],
        ),
        trailing: IconButton(onPressed: (){
          onRemoveClicked(serre.id);
        }, icon: const Icon(Icons.delete ,color: Colors.red,)),
      ),
    );
  }
}
