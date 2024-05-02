import 'package:flutter/material.dart';

class ConfirmPinScreen extends StatefulWidget {
  const ConfirmPinScreen({super.key});

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Confirm pin screen",
        ),
      ),
    );
  }
}
