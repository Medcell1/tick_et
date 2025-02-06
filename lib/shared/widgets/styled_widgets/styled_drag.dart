import 'package:flutter/material.dart';
import 'package:ticket_app_flutter/shared/themes/themes.dart';

class StyledDrag extends StatelessWidget {
  const StyledDrag({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 4.0,
        width: 36.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: dragColor,
        ),
      ),
    );
  }
}
