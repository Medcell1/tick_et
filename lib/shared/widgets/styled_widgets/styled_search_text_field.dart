import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticket_app_flutter/shared/extensions/extensions.dart';
import 'package:ticket_app_flutter/shared/themes/themes.dart';
import 'package:ticket_app_flutter/shared/widgets/widgets.dart';

class StyledSearchTextField extends StatefulWidget {
  final TextEditingController? controller;
  final OverlayVisibilityMode suffixMode;
  final bool autofocus;
  final VoidCallback? onClear;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final String? placeholder;
  final String? iconPath;
  final String cancelText;
  final FocusNode? focusNode;
  final Widget? suffixIcon;

  const StyledSearchTextField({
    super.key,
    this.controller,
    this.suffixMode = OverlayVisibilityMode.never,
    this.autofocus = false,
    this.onClear,
    this.onChanged,
    this.onSubmitted,
    this.placeholder,
    this.iconPath,
    required this.cancelText,
    this.focusNode,
    this.suffixIcon,
  });

  @override
  State<StyledSearchTextField> createState() => _StyledSearchTextFieldState();
}

class _StyledSearchTextFieldState extends State<StyledSearchTextField> {
  late final TextEditingController _controller;
  bool _disposeTextController = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();

    if (widget.controller == null) {
      _disposeTextController = true;
    }
  }

  @override
  void dispose() {
    if (_disposeTextController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                SizedBox(
                  height: 40.0,
                  child: CupertinoSearchTextField(
                    placeholder: widget.placeholder,
                    controller: widget.controller,
                    suffixMode: widget.suffixMode,
                    autofocus: widget.autofocus,
                    borderRadius: BorderRadius.circular(12.0),
                    prefixIcon: SvgPicture.asset(
                      widget.iconPath ?? 'assets/icons/common/search.svg',
                    ).padOnly(left: 4.0, top: 2.0, right: 2.0),
                    placeholderStyle: size14weight500
                        .withHeight(17.5)
                        .withColor(greyScale50)
                        .copyWith(inherit: false),
                    style: size14weight500
                        .withHeight(17.5)
                        .withColor(greyScale00)
                        .copyWith(inherit: false),
                    onSubmitted: widget.onSubmitted,
                    onChanged: widget.onChanged,
                    focusNode: widget.focusNode,
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 8,
                  child: widget.suffixIcon ?? const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: Listenable.merge([
              _controller,
              widget.focusNode,
            ]),
            builder: (context, child) {
              final bool isTextFieldNotEmpty =
                  widget.controller?.text.isNotEmpty == true;
              final isFocused = widget.focusNode?.hasFocus == true;
              final showClearButton = isTextFieldNotEmpty || isFocused;

              return AnimatedCrossFade(
                duration: kThemeAnimationDuration,
                crossFadeState: showClearButton
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: child!,
                secondChild: const SizedBox.shrink(),
              );
            },
            child: IncreasedTouchDetector(
              onTap: () {
                final bool isTextFieldEmpty =
                    widget.controller?.text.isEmpty == true;
                widget.onClear?.call();
                if (isTextFieldEmpty) {
                  widget.focusNode?.unfocus();
                }
              },
              child: Text(
                widget.cancelText,
                style: size14weight500.withHeight(16.94).withColor(greyScale00),
              ),
            ).padLeft(8.0),
          ),
        ],
      ),
    );
  }
}
