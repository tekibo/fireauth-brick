import 'package:flutter/material.dart';

Widget colorBar({required Color color, double? width, double? height}) {
  return SizedBox(
    height: height ?? 4,
    width: width ?? 40,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(height ?? 2),
      ),
    ),
  );
}
