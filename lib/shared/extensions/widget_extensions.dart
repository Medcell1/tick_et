import 'package:flutter/material.dart';

extension WidgetX on Widget {
  /// Returns a [MaterialPageRoute] with this [Widget] as the builder.
  Route get route {
    return MaterialPageRoute(builder: (context) => this);
  }

  /// Adds padding to the top of this [Widget] with the specified value.
  Widget padTop(double value) {
    return Padding(
      padding: EdgeInsets.only(top: value),
      child: this,
    );
  }

  /// Adds padding to the right side of this [Widget] with the specified value.
  Widget padRight(double value) {
    return Padding(
      padding: EdgeInsets.only(right: value),
      child: this,
    );
  }

  /// Adds padding to the left side of this [Widget] with the specified value.
  Widget padLeft(double value) {
    return Padding(
      padding: EdgeInsets.only(left: value),
      child: this,
    );
  }

  /// Adds padding to the bottom of this [Widget] with the specified value.
  Widget padBottom(double value) {
    return Padding(
      padding: EdgeInsets.only(bottom: value),
      child: this,
    );
  }

  /// Adds padding to the horizontal axis of this [Widget] with the specified value.
  Widget padHorizontal(double value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: value),
      child: this,
    );
  }

  /// Adds padding to the vertical axis of this [Widget] with the specified value.
  Widget padVertical(double value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: value),
      child: this,
    );
  }

  /// Adds padding to all sides of this [Widget] with the specified value.
  Widget padAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  /// Adds padding to this [Widget] with the specified values for each side (left,
  /// top, right, bottom). Not specified sides get 0.0 padding.
  Widget padOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }

  /// Wraps this [Widget] in a [SliverToBoxAdapter], making it usable inside a
  /// [CustomScrollView].
  Widget toSliver() {
    return SliverToBoxAdapter(child: this);
  }

  /// Limits the width of this [Widget] to the specified value.
  Widget inWidthOf(double value) {
    return SizedBox(
      width: value,
      child: this,
    );
  }

  /// Limits the height of this [Widget] to the specified value.
  Widget inHeightOf(double value) {
    return SizedBox(
      height: value,
      child: this,
    );
  }

  /// Limits the size of this [Widget] to the specified width and height.
  Widget inSizeOf(double width, double height) {
    return SizedBox(
      height: height,
      width: width,
      child: this,
    );
  }
}
