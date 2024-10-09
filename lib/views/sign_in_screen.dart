import 'package:cafem/consts/color_pallete.dart';
import 'package:cafem/controller/Auth_controller.dart';
import 'package:cafem/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailFeild = TextEditingController();
  TextEditingController passFeild = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100.h),
              Text(
                "Sign In",
                style: TextStyle(
                    color: AppColors.PurpuleColor,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              customTextFeild(
                required: true,
                controller: emailFeild,
                text: "Username",
                icon: Icons.person_outline_outlined,
              ),
              const SizedBox(
                height: 40,
              ),
              customTextFeild(
                  required: true,
                  controller: passFeild,
                  text: "Password",
                  icon: Icons.lock_outline_rounded,
                  icon1: Icons.remove_red_eye_outlined),
              SizedBox(
                height: 20.h,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(
                        color: AppColors.PurpuleColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              SizedBox(
                height: 50.h,
                width: double.infinity,
                child:
                    Consumer<AuthController>(builder: (context, controller, _) {
                  return FilledButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(AppColors.LightPurpleColor),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        AuthController().signIn(
                            email: emailFeild.text, password: passFeild.text);
                      }
                    },
                    child: controller.isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Sign In",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                  );
                }),
              ),
              SizedBox(
                height: 90.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have account?",
                    style: TextStyle(
                        color: AppColors.PurpuleColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.normal),
                  ),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(appContext).goNamed(Routes.signnup.name);
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: AppColors.PurpuleColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  customTextFeild({
    text,
    icon,
    icon1,
    controller,
    required = false,
  }) {
    return TextFormField(
      validator: required
          ? (value) {
              if (value == null || value == "") {
                return "This Feild Is Requried";
              }
            }
          : null,
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        prefixIcon: Icon(
          icon,
          size: 28.sp,
          color: AppColors.PurpuleColor,
        ),
        suffixIcon: Icon(icon1, size: 28.sp, color: Colors.grey.shade600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: AppColors.PurpuleColor)),
      ),
    );
  }
}
