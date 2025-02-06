import 'package:flutter/material.dart';

extension SizedBoxNumExtension on num {
  Widget spaceHeight() => SizedBox(
        height: toDouble(),
      );

  Widget spaceWidth() => SizedBox(
        width: toDouble(),
      );
}
