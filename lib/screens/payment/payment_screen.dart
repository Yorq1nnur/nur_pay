import 'package:flutter/material.dart';
import 'package:nur_pay/utils/utility_functions/utility_functions.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    super.key,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
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
            "Payment screen",
          ),
        ),
      ),
    );
  }
}
