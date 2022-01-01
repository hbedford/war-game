import 'package:flutter/material.dart';

class SnackbarError extends SnackBar {
  final String text;
  SnackbarError({required this.text})
      : super(
            content: Container(
          child: Text(text),
        ));
}
