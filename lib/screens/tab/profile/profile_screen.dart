import 'package:flutter/material.dart';
import 'package:nur_pay/utils/utility_functions/utility_functions.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
            "Profile Screen",
          ),
        ),
      ),
    );
  }
}
