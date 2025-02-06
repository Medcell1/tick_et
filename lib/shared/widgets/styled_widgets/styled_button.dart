import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ticket_app_flutter/shared/extensions/extensions.dart';
import 'package:ticket_app_flutter/shared/widgets/styled_widgets/styled_loading_indicator.dart';

import '../../themes/theme_globals.dart';

class StyledButton extends StatefulWidget {
  final String? label;
  final VoidCallback? onTap;
  final bool hides;
  final Color color;
  final Color? borderColor;
  final Color? textColor;
  final Widget? icon;
  final bool busy;
  final bool _flat;
  final TextStyle? textStyle;
  final BorderRadius borderRadius;
  final double height;
  final EdgeInsets? padding;

  const StyledButton({
    super.key,
    required this.label,
    this.onTap,
    this.hides = false,
    this.color = primaryColor,
    this.borderColor,
    this.textColor,
    this.icon,
    this.busy = false,
    this.textStyle,
    this.borderRadius = const BorderRadius.all(Radius.circular(16.0)),
    this.height = 56.0,
    this.padding,
  }) : _flat = true;

  const StyledButton.flat({
    super.key,
    required this.label,
    this.onTap,
    this.hides = false,
    this.color = primaryColor,
    this.borderColor,
    this.textColor,
    this.icon,
    this.busy = false,
    this.textStyle,
    this.borderRadius = const BorderRadius.all(Radius.circular(16.0)),
    this.height = 56.0,
    this.padding,
  }) : _flat = false;

  @override
  State<StyledButton> createState() => _StyledButtonState();
}

class _StyledButtonState extends State<StyledButton> {
  Timer? _debounceTimer;
  bool _isDebounced = false;

  void _handleTap() {
    if (widget.onTap != null && !_isDebounced) {
      widget.onTap!();
      _startDebounce();
    }
  }

  void _startDebounce() {
    setState(() {
      _isDebounced = true;
    });
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _isDebounced = false;
      });
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color? disabledBackgroundColor = greyScale92;
    final isDisabled = widget.onTap == null || widget.busy;
    final effectiveTextColor = isDisabled ? greyScale50 : widget.textColor;

    return AnimatedSwitcher(
      duration: firstDelayDuration,
      child: (widget.hides && widget.onTap == null)
          ? const SizedBox.shrink()
          : GestureDetector(
              onTap: _handleTap,
              child: Container(
                height: widget.height,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: widget.borderRadius,
                  color: isDisabled ? disabledBackgroundColor : widget.color,
                  border: widget.borderColor != null
                      ? Border.all(
                          color: widget.borderColor!,
                          width: 1.0,
                        )
                      : null,
                  boxShadow: [
                    if (!isDisabled && widget._flat)
                      BoxShadow(
                        color: widget.color.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                  ],
                ),
                padding: widget.padding,
                child: _buildChild(effectiveTextColor),
              ),
            ),
    );
  }

  Widget _buildChild(Color? effectiveTextColor) {
    if (widget.busy) {
      return const StyledLoadingIndicator(color: greyScale00);
    }

    if (widget.icon == null) {
      return _buildText(effectiveTextColor);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.icon!,
        const SizedBox(width: 8.0),
        _buildText(effectiveTextColor),
      ],
    );
  }

  Widget _buildText(Color? effectiveTextColor) {
    return Text(
      widget.label.asValidString(),
      textAlign: TextAlign.center,
      style: (widget.textStyle ?? size16weight600)
          .withColor(effectiveTextColor ?? Colors.white)
          .withHeight(20),
    );
  }
}
