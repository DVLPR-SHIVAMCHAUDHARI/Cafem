import 'package:cafem/consts/customtextfeild.dart';
import 'package:cafem/controller/Auth_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class Forgotpassword extends StatelessWidget {
  Forgotpassword({super.key});

  final formKey = GlobalKey<FormState>();

  TextEditingController emailfield = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 300.h,
              ),
              customTextFiled(
                  required: true,
                  controller: emailfield,
                  hinttext: "Enter your email id"),
              SizedBox(
                height: 20.h,
              ),
              FilledButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();

                      AuthController().forgetPassword(emailfield.text);
                      GoRouter.of(context).pop();
                    }
                  },
                  child: const Text("Reset password"))
            ],
          ),
        ),
      ),
    );
  }
}
