import 'package:cafem/consts/color_pallete.dart';

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
          }
        : null,
    obscureText: obs,
    controller: controller,
    decoration: InputDecoration(
      hintText: hinttext,
      prefixIcon: Icon(
        icon,
        color: AppColors.PurpuleColor,
        size: 25,
      ),
      suffixIcon: suffixicon,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.PurpuleColor)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.PurpuleColor)),
      hintStyle: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 15.sp,
          fontWeight: FontWeight.normal),
    ),
  );
}
