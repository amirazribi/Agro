import 'package:detection/ui/auth/controllers/auth_controller.dart';
import 'package:detection/ui/auth/login_view.dart';
import 'package:detection/ui/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/form_input_field_with_icon.dart';
import '../components/label_button.dart';
import '../components/primary_button.dart';
import '../components/validator.dart';

class ResetPasswordView extends StatelessWidget {
   ResetPasswordView({Key? key}) : super(key: key);

  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                 // LogoGraphicHeader(),
                  SizedBox(height: 48.0),
                  FormInputFieldWithIcon(
                    controller: authController.emailController,
                    iconPrefix: Icons.email,
                    labelText: "Adresse email",
                    validator: Validator().email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                    authController.emailController.text = value as String,
                  ),
                  verticalSpaceMedium,
                  PrimaryButton(
                      labelText: 'Envoyer Password Reset',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await authController.sendPasswordResetEmail(context);
                        }
                      }),
                  verticalSpaceMedium,
                  signInLink(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  appBar(BuildContext context) {
    if (authController.emailController.text == '') {
      return null;
    }
    return AppBar(title: Text('réinitialiser le mot de passe'));
  }

  signInLink(BuildContext context) {
    if (authController.emailController.text == '') {
      return LabelButton(
        labelText: 'S\'identifier',
        onPressed: () => Get.offAll(LoginView()),
      );
    }
    return Container(width: 0, height: 0);
  }
}