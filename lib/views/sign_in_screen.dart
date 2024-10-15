import 'package:cafem/consts/customtextfeild.dart';
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
  bool _ispass = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailFeild = TextEditingController();
  TextEditingController passFeild = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100.h),
                Text(
                  "Sign In",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                customTextFiled(
                  required: true,
                  controller: emailFeild,
                  hinttext: "Username",
                  icon: Icons.person_outline_outlined,
                ),
                const SizedBox(
                  height: 40,
                ),
                customTextFiled(
                  required: true,
                  obs: _ispass,
                  controller: passFeild,
                  hinttext: "Password",
                  icon: Icons.lock_outline_rounded,
                  suffixicon: IconButton(
                      onPressed: () {
                        setState(() {
                          _ispass = !_ispass;
                        });
                      },
                      icon: _ispass
                          ? Icon(
                              Icons.visibility_outlined,
                              color: Colors.blue,
                            )
                          : Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.blue,
                            )),
                ),
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
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                SizedBox(
                  height: 50.h,
                  width: double.infinity,
                  child: Consumer<AuthController>(
                      builder: (context, controller, _) {
                    return FilledButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          AuthController().signIn(
                              email: emailFeild.text, password: passFeild.text);
                        }
                      },
                      child: controller.isLoading
                          ? SizedBox(
                              width: 10,
                              height: 10,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              "Sign in",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
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
                          color: Colors.blue,
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
                            color: Colors.blue,
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
      ),
    );
  }
}
