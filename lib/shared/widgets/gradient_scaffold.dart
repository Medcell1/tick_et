import 'package:ticket_app_flutter/features/home/home.dart';

class GradientScaffold extends StatelessWidget {
  final Widget child;

  const GradientScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.2, 0.4, 0.6, 0.8, 0.99],
          colors: [
            AppColors.primaryDark,
            Color(0xFF3d3c67),
            Color(0xFFa16492),
            AppColors.primaryDark,
            AppColors.primaryDark,
          ],
        ),
      ),
      child: child,
    );
  }
}
