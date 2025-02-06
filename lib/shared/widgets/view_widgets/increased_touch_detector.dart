import 'package:flutter/material.dart';
import 'package:ticket_app_flutter/shared/constants/constants.dart';

class IncreasedTouchDetector extends StatelessWidget {
  const IncreasedTouchDetector({
    super.key,
    required this.onTap,
    required this.child,
    this.disabled = false,
  });

  final VoidCallback onTap;
  final bool disabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    const hitboxMargin = EdgeInsets.all(CommonValues.tapRegionInflation);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          left: -hitboxMargin.left,
          right: -hitboxMargin.right,
          top: -hitboxMargin.top,
          bottom: -hitboxMargin.bottom,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: disabled ? null : onTap,
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}
