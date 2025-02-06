import 'package:flutter/material.dart';
import 'package:ticket_app_flutter/shared/themes/colors.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget content;

  const CustomButton({
    super.key,
    this.onPressed,
    required this.content,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _animation =
        Tween<double>(begin: 0.0, end: 5.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.onPressed == null
                    ? [AppColors.accentPink, Colors.blue]
                    : [AppColors.primaryDark, AppColors.accentPink],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 2,
                style: BorderStyle.solid,
                color: widget.onPressed != null
                    ? Colors.white.withOpacity(0.5)
                    : Colors.transparent,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.7),
                  blurRadius: 6,
                ),
                if (widget.onPressed != null)
                  BoxShadow(
                    color: AppColors.accentPink.withOpacity(0.9),
                    blurRadius: _animation.value,
                    spreadRadius: _animation.value,
                  ),
              ],
            ),
            child: Center(
              child: widget.content,
            ),
          );
        },
      ),
    );
  }
}
