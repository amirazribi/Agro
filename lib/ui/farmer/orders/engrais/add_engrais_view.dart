import 'package:detection/models/enum/engrais_type.dart';
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

class AddEngraisView extends StatelessWidget {
  AddEngraisView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter Commande engrais"),
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
                  FormBuilderDropdown<EngraisType>(
                    name: 'typeEngrais',
                    decoration: const InputDecoration(
                      labelText: 'Type du Engrais',
                    ),
                    items: EngraisType.values
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type.name),
                            ))
                        .toList(),
                    validator: (type) =>
                        type == null ? "choisir type d'engrais" : null,
                  ),
                  verticalSpaceMedium,
                  FormBuilderTextField(
                    name: 'quantity',
                    decoration: const InputDecoration(
                      labelText: 'Quantité',
                      suffixText: "Kg"
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        int.parse(value ?? "0",) == 0
                            ? "ajouter quantité"
                            : null,
                  ),
                  verticalSpaceMedium,
                  FormBuilderTextField(
                    name: 'address',
                    decoration: const InputDecoration(
                      labelText: 'Adresse de commande',
                    ),
                    validator: (address) => address == null
                        ? "ajouter une adresse de commande"
                        : null,
                  ),
                  verticalSpaceMedium,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PrimaryButton(
                          labelText: "Valider Commande",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final EngraisType typeEngrais = _formKey
                                  .currentState?.fields["typeEngrais"]?.value;
                              Get.find<OrderService>().createOrder(OrderModel(
                                  address: _formKey
                                      .currentState?.fields["address"]?.value,
                                  date: DateTime.now().toString(),
                                  quantity: int.parse(
                                      _formKey.currentState?.fields["quantity"]
                                          ?.value as String,
                                     ),
                                  farmerId:
                                      FirebaseAuth.instance.currentUser?.uid,
                                  farmerName: AuthController
                                      .to.firestoreUser.value?.name,
                                  type: OrderType.engrais ,
                              engraisType: typeEngrais));
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
