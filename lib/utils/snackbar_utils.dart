import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
  BuildContext _,
  String message,
) {
  return ScaffoldMessenger.of(_).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14.0,
        ),
      ),
    ),
  );
}
