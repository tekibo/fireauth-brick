import 'package:flutter/material.dart';

class SafeAreaCenter extends StatelessWidget {
  const SafeAreaCenter({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Center(child: child));
  }
}
