import 'package:detection/models/enum/visites_type.dart';
import 'package:detection/models/order_model.dart';
import 'package:detection/services/order_service.dart';
import 'package:detection/ui/components/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../models/enum/order_type.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../../../components/primary_button.dart';

class AddVisitesView extends StatelessWidget {
  AddVisitesView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajouter patient"),
      ),
      body: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SizedBox(
              width: width * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormBuilderDropdown<VisitesType>(
                    name: 'typeMaladie',
                    decoration: const InputDecoration(
                      labelText: 'Type du Maladie',
                    ),
                    items: VisitesType.values
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type.name),
                            ))
                        .toList(),
                    validator: (type) =>
                        type == null ? "choisir type de maladie" : null,
                  ),
                  verticalSpaceMedium,
                  FormBuilderTextField(
                    name: 'prix',
                    decoration: const InputDecoration(
                      labelText: 'Prix',
                      suffixText: "Dt"
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        int.parse(value ?? "0",) == 0
                            ? "ajouter prix"
                            : null,
                  ),
                  verticalSpaceMedium,
                  FormBuilderTextField(
                    name: 'address',
                    decoration: const InputDecoration(
                      labelText: 'Adresse patient',
                    ),
                    validator: (address) => address == null
                        ? "ajouter une adresse patient "
                        : null,
                  ),
                  verticalSpaceMedium,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PrimaryButton(
                          labelText: "Valider",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {

                              final VisitesType typeVisites = _formKey
                                  .currentState?.fields["typeMaladie"]?.value;
                              Get.find<OrderService>().createOrder(OrderModel(
                                  address: _formKey
                                      .currentState?.fields["address"]?.value,
                                  date: DateTime.now().toString(),
                                  prix: int.parse(
                                      _formKey.currentState?.fields["prix"]
                                          ?.value as String,
                                     ),
                                  infermierId:
                                      FirebaseAuth.instance.currentUser?.uid,
                                  infermierName: AuthController
                                      .to.firestoreUser.value?.name,
                                  type: OrderType.visites ,
                              visitesType: typeVisites));
                              Get.back();
                            }
                          }),
                      PrimaryButton(
                        labelText: "Annuler",
                        onPressed: Get.back,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
