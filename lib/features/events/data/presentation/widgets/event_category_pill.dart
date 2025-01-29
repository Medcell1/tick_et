import 'package:flutter/material.dart';
import 'package:ticket_app_flutter/shared/themes/colors.dart';

class EventCategoryPill extends StatelessWidget {
  final String text;

  const EventCategoryPill({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [

            AppColors.primaryDark,
            AppColors.primaryLight,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
