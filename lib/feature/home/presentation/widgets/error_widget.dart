// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:weather_forecast/core/functions/text_styles.dart';

class ErrorScreen extends StatelessWidget {
  final String error;
  const ErrorScreen({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        error.toString(),
        style: myStyle(color: Colors.red),
      )),
    );
  }
}
