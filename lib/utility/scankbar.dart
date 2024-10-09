import 'package:cafem/main.dart';
import 'package:flutter/material.dart';

displaySnackbar(message, {color = Colors.red}) {
  ScaffoldMessenger.of(appContext).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(message),
    ),
  );
}
