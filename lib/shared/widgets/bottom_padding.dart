import 'package:flutter/material.dart';

/// A widget that adds bottom padding to its child equal to the value of the
/// device's bottom media query padding. If there is no padding, a default
/// spacing value is used instead.
class BottomPadding extends StatelessWidget {
  /// The default spacing value used when there is no bottom media query padding.
  final double spacing;

  const BottomPadding({
    super.key,
    this.spacing = 16.0,
  });

  /// Returns the value of the bottom media query padding from the given context.
  static double of(BuildContext context) =>
      MediaQuery.of(context).padding.bottom;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    final height = bottom > 0.0 ? bottom : spacing;

    return SizedBox(height: height);
  }
}
