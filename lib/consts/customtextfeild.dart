import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

customTextFiled({
  bool obs = false,
  hinttext,
  icon,
  controller,
  Widget? suffixicon,
  required = false,
}) {
  return TextFormField(
    validator: required
        ? (value) {
            if (value == null || value == "") {
              return "This Feild Is Requried";
            }
            return null;
          }
        : null,
    obscureText: obs,
    controller: controller,
    decoration: InputDecoration(
      hintText: hinttext,
      prefixIcon: Icon(
        icon,
        color: Colors.blue,
        size: 25,
      ),
      suffixIcon: suffixicon,
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(15.r)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.blue)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.blue)),
      hintStyle: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 15.sp,
          fontWeight: FontWeight.normal),
    ),
  );
}
