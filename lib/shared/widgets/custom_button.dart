import 'package:flutter/material.dart';
import 'package:ticket_app_flutter/shared/themes/colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget content;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primaryDark, AppColors.accentPink],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 2,
            style: BorderStyle.solid,
            color: Colors.transparent,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              // offset: const Offset(1, 1),
              blurRadius: 5,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.7),
              // offset: const Offset(0, 0),
              blurRadius: 6,
            ),
          ],
        ),
        child: Center(
          child: content,
        ),
      ),
    );
  }
}
