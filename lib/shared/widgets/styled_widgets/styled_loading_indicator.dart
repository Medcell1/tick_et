import 'package:flutter/material.dart';

class StyledLoadingIndicator extends StatelessWidget {
  const StyledLoadingIndicator({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: color,
      ),
    );
  }
}
