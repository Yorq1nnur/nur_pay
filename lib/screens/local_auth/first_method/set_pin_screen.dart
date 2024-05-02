import 'package:flutter/material.dart';
import 'package:nur_pay/utils/utility_functions/utility_functions.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: systemUiOverlayStyle,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Set pin screen",
          ),
        ),
      ),
    );
  }
}
