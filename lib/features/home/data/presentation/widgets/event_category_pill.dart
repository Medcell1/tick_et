import 'package:ticket_app_flutter/features/home/home.dart';

class EventCategoryPill extends StatelessWidget {
  final String text;
  final String id;

  const EventCategoryPill({super.key, required this.text, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/categories', extra: {"selectedCategory": id}),
      child: Container(
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
      ),
    );
  }
}
