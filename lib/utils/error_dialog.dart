import 'package:flutter/material.dart';
import '../models/custom_error.dart';

void showErrorDialog(BuildContext context, CustomError customError) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Error'),
      content: Text('${customError.resultCode}\n${customError.message}'),
      actions: [
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
