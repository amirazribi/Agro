import 'package:detection/models/consultation_model.dart';
import 'package:detection/ui/components/utils.dart';
import 'package:detection/ui/doctor/Consultation/detail/consultation_detail_view.dart';
import 'package:detection/utlis/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsultationItem extends StatelessWidget {
  final ConsultationModel consultation;
  final Function(String?) onRemoveClicked;

   ConsultationItem({Key? key, required this.consultation ,required this.onRemoveClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white60,
      child: ListTile(
        onTap: (){
          Get.to(()=>ConsultationDetailView(),arguments: [
            {
              "model": consultation,
            }
          ]);
        },
        leading: buildLeading(),
        title: Row(

          children: [
            Text(consultation.nature ?? "",style: TextStyle(fontSize: 14)),
            horizontalSpaceMedium,
            Text(consultation.subNature ?? ""),
          ],
        ),
        subtitle: Row(
          children: [
            const Text("date de consultation :" ,style: TextStyle(fontSize: 12)),
            Text(consultation.date ?? "" ,style: TextStyle(fontSize: 12)),
          ],
        ),
        trailing: IconButton(onPressed: (){
          onRemoveClicked(consultation.id);
        }, icon: const Icon(Icons.delete ,color: Colors.red,)),
      ),
    );
  }

 Widget buildLeading() {
    if(consultation.nature?.toLowerCase() == Constants.tomato.toLowerCase()){
      return Image.asset("assets/tomato.jpg");
    }else if (consultation.nature?.toLowerCase() == Constants.potato.toLowerCase()){
      return Image.asset("assets/potato.jpg");
    }else {
      return Text(consultation.name ?? "" ,style: TextStyle(fontSize: 18),);
    }
 }
}
