import 'package:flutter/material.dart';

import '../themes/colors.dart';

class GradientScaffold extends StatelessWidget {
  final Widget child;

  const GradientScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.45, 1.0],
          colors: [
            AppColors.primaryDark,
            AppColors.primaryDark.withOpacity(0.45),
            AppColors.primaryLight,
          ],
        ),
      ),
      child: child,
    );
  }
}
