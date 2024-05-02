import 'package:flutter/material.dart';
import 'package:nur_pay/utils/utility_functions/utility_functions.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({
    super.key,
  });

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return AnnotatedRegion(
      value: systemUiOverlayStyle,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Transfer screen",
          ),
        ),
      ),
    );
  }
}
