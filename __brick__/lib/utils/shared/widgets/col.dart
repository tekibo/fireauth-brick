import 'package:flutter/material.dart';

class Col extends StatelessWidget {
  const Col({
    super.key,
    this.scrollable = false,
    this.outerPadding,
    this.outerPaddingX,
    this.outerPaddingY,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.spacing = 0,
    required this.children,
  });

  final bool scrollable;
  final double? outerPadding;
  final double? outerPaddingX;
  final double? outerPaddingY;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final double spacing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final Widget column = Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      spacing: spacing,
      children: children,
    );

    if (scrollable) {
      return padded(
        outerPadding: outerPadding,
        outerPaddingX: outerPaddingX,
        outerPaddingY: outerPaddingY,
        child: SingleChildScrollView(child: column),
      );
    }

    return padded(
      outerPadding: outerPadding,
      outerPaddingX: outerPaddingX,
      outerPaddingY: outerPaddingY,
      child: column,
    );
  }
}

Widget padded({
  required Widget child,
  double? outerPadding,
  double? outerPaddingX,
  double? outerPaddingY,
}) {
  if (outerPadding != null && outerPaddingX == null && outerPaddingY == null) {
    return Padding(padding: EdgeInsets.all(outerPadding), child: child);
  }

  if (outerPaddingX != null || outerPaddingY != null) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: outerPaddingX ?? 0,
        vertical: outerPaddingY ?? 0,
      ),
      child: child,
    );
  }

  return child;
}
