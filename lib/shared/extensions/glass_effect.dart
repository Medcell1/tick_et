import 'package:flutter/material.dart';
import 'dart:ui';

extension GlassWidget<T extends Widget> on T {
  Widget asGlass({
    bool enabled = true,
    double blurX = 10.0,
    double blurY = 10.0,
    Color tintColor = Colors.white,
    bool frosted = true,
    BorderRadius clipBorderRadius = BorderRadius.zero,
    Clip clipBehaviour = Clip.antiAlias,
    TileMode tileMode = TileMode.clamp,
    CustomClipper<RRect>? clipper,
  }) {
    return !enabled
        ? this
        : ClipRRect(
            clipper: clipper,
            clipBehavior: clipBehaviour,
            borderRadius: clipBorderRadius,
            child: BackdropFilter(
              filter: new ImageFilter.blur(
                sigmaX: blurX,
                sigmaY: blurY,
                tileMode: tileMode,
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: (tintColor != Colors.transparent)
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            tintColor.withOpacity(0.1),
                            tintColor.withOpacity(0.08),
                          ],
                        )
                      : null,
                  image: frosted
                      ? const DecorationImage(
                          image:
                              AssetImage('images/noise.png', package: 'glass'),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: this,
              ),
            ),
          );
  }
}
