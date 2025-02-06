import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:ticket_app_flutter/features/home/home.dart';
import 'package:ticket_app_flutter/shared/extensions/extensions.dart';
import 'package:ticket_app_flutter/shared/themes/themes.dart';
import 'package:ticket_app_flutter/shared/widgets/styled_widgets/styled_loading_indicator.dart';

class StyledTextField<T> extends StatefulWidget {
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? hintColor;
  final Color? textColor;
  //
  final String? iconAssetName;
  final TextInputType textInputType;
  final String? hintText;
  final bool autoFocus;
  final bool obscurable;
  final Widget? suffix;
  final int? maxLines;
  final int? maxLength;
  final Widget? prefix;
  final double borderRadius;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final Map<String, String> validationMessages;
  final FormControl? formControl;
  final BorderRadius? shape;
  final String? name;
  final TextCapitalization textCapitalization;
  final void Function(FormControl<T>)? onSubmitted;
  final FocusNode? focusNode;
  final Future<T?> Function()? onTap;
  final List<String>? autofillHints;
  final ControlValueAccessor<T, String>? valueAccessor;
  final bool busy;
  final bool readOnly;
  final bool hideChevronIfVisible;
  final bool _noLabel;
  final bool showError;
  final String? prefixText;
  final String? suffixText;
  final TextEditingController? controller;
  final Function(T?)? onChanged;
  final bool outline;

  const StyledTextField({
    this.backgroundColor = Colors.transparent,
    this.borderColor = greyScale72,
    this.hintColor = greyScale92,
    this.textColor = greyScale96,
    required this.name,
    this.textInputType = TextInputType.text,
    this.autoFocus = false,
    this.iconAssetName,
    this.maxLength,
    this.hintText,
    this.suffix,
    this.shape,
    this.prefix,
    this.maxLines,
    this.formControl,
    this.obscurable = false,
    this.inputFormatters,
    this.textInputAction,
    this.validationMessages = const {},
    this.borderRadius = 16.0,
    this.textCapitalization = TextCapitalization.words,
    this.onSubmitted,
    this.focusNode,
    this.onTap,
    this.autofillHints,
    this.valueAccessor,
    this.busy = false,
    this.readOnly = false,
    this.hideChevronIfVisible = false,
    this.showError = true,
    super.key,
    this.prefixText,
    this.suffixText,
    this.controller,
    this.onChanged,
    this.outline = true,
  }) : _noLabel = false;

  const StyledTextField.noLabel({
    super.key,
    this.backgroundColor,
    this.borderColor,
    this.hintColor,
    this.textColor,
    required this.name,
    this.textInputType = TextInputType.text,
    this.autoFocus = false,
    this.iconAssetName,
    this.maxLength,
    this.suffix,
    this.shape,
    this.prefix,
    this.maxLines,
    this.formControl,
    this.obscurable = false,
    this.inputFormatters,
    this.textInputAction,
    this.validationMessages = const {},
    this.borderRadius = 16.0,
    this.textCapitalization = TextCapitalization.words,
    this.onSubmitted,
    this.focusNode,
    this.onTap,
    this.autofillHints,
    this.valueAccessor,
    this.busy = false,
    this.hideChevronIfVisible = false,
    this.showError = true,
    this.readOnly = false,
    this.prefixText,
    this.suffixText,
    this.controller,
    this.onChanged,
    this.outline = false,
  })  : _noLabel = true,
        hintText = null;

  @override
  State<StyledTextField<T>> createState() => _StyledTextFieldState<T>();
}

class _StyledTextFieldState<T> extends State<StyledTextField<T>> {
  late bool _obscurable;
  late FocusNode _focusNode;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _obscurable = widget.obscurable;
    _focusNode = widget.focusNode ?? FocusNode();

    if (widget.suffixText != null) {
      _controller.addListener(() {
        String text = _controller.text.replaceAll(widget.suffixText!, '');
        if (text.isNotEmpty) {
          text = '$text${widget.suffixText!}';
          _controller.value = _controller.value.copyWith(
            text: text,
          );
        } else {
          _controller.value = _controller.value.copyWith(
            text: '',
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onTap != null) {
      return GestureDetector(
        onTap: () async {
          /// If the widget is busy, we don't want to do anything.
          if (widget.busy) return;

          FocusScope.of(context).unfocus();

          final formGroup = context.reactiveFormGroup;

          final result = await widget.onTap?.call();

          if (result != null) {
            Map<String, dynamic> value = {};
            value.addAll(
              formGroup!.controls.map(
                (key, value) {
                  return MapEntry(key, value.value);
                },
              ),
            );
            value[widget.name!] = result;

            formGroup.updateValue(value);
          }
        },
        child: AbsorbPointer(
          child: _buildTextField(),
        ),
      );
    }

    return _buildTextField();
  }

  Widget _buildTextField() {
    final validationMessages = {
      ValidationMessage.required: (_) {
        return 'Cannot be empty';
      },
      ValidationMessage.email: (_) {
        return 'Not valid email';
      },
      ValidationMessage.number: (_) {
        return 'Not a valid number';
      },
      ValidationMessage.maxLength: (value) {
        final int? requiredLength = value['requiredLength'];

        return '${'max_length'}: $requiredLength';
      },
      ValidationMessage.minLength: (value) {
        final int? requiredLength = value['requiredLength'];

        return '${'min_required'}: $requiredLength';
      },
      ValidationMessage.min: (value) {
        final int? min = value['min'];
        return 'Must be higher than $min';
      },
      ValidationMessage.max: (value) {
        final int? max = value['max'];
        return 'Must be lower than $max';
      },
      ValidationMessage.pattern: (_) {
        return 'Not Valid';
      },
      'invalid_tax': (_) {
        return 'Invalid Tax';
      },
      'invalid_discount': (_) {
        return 'Invalid Discount';
      },
      'invalid_price': (_) {
        return 'Invalid Price';
      },
    };

    final manualValidationMessages = widget.validationMessages.map(
      (key, value) {
        return MapEntry(key, (_) => value);
      },
    );

    validationMessages.addAll(manualValidationMessages);
    final formGroup = context.reactiveFormGroup;
    final isDisabled = context.isFormDisabled(widget.name!);

    return AnimatedBuilder(
      animation: _focusNode,
      builder: (_, __) {
        final isFocused = _focusNode.hasFocus;

        final Color activeLabelColor =
            isFocused ? primaryColor : (widget.hintColor ?? greyScale54);
        final Color labelColor = isDisabled ? greyScale50 : activeLabelColor;
        final Color valueColor = isDisabled
            ? greyScale50
            : (widget.textColor ?? textFieldValueColor);

        final double verticalPadding = context.isMobile ? 9.0 : 12.5;
        final double labelHeight = context.isMobile ? 21 / 16 : 0.7;

        final hasError = context.formValueHasError(widget.name!);
        final firstError =
            formGroup?.control(widget.name!).errors.keys.firstOrNull;
        final hasErrorMessage = validationMessages.containsKey(firstError);
        final errorMessage = hasErrorMessage
            ? validationMessages[firstError!]
                ?.call(formGroup!.control(widget.name!).errors[firstError])
            : '';

        print('OMO -> ${widget.backgroundColor}');

        return Column(
          children: [
            Container(
              decoration: widget.outline
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      border: Border.all(
                        color: hasError
                            ? Colors.red
                            : (widget.borderColor ?? const Color(0xFFFAFAFA)),
                        width: 1.0,
                      ),
                    )
                  : null,
              child: ReactiveTextField<T>(
                controller: _controller,
                focusNode: _focusNode,
                valueAccessor: widget.valueAccessor,
                autofillHints: widget.autofillHints,
                formControl: widget.formControl as FormControl<T>?,
                formControlName: widget.name,
                validationMessages: validationMessages,
                textAlignVertical: TextAlignVertical.center,
                autofocus: widget.autoFocus,
                onSubmitted: widget.onSubmitted?.call,
                keyboardType: widget.textInputType,
                style: size16weight500.copyWith(
                  height: 24 / 16,
                  color: hasError ? redColor : valueColor,
                ),
                obscureText: _obscurable,
                cursorColor: primaryColor,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(widget.maxLength),
                  ...widget.inputFormatters ?? [],
                ],
                maxLines: widget.maxLines ?? 1,
                maxLength: widget.maxLength,
                textInputAction: widget.textInputAction,
                textCapitalization: widget.textCapitalization,
                onChanged: (FormControl<T> control) {
                  widget.onChanged?.call(control.value);
                },
                decoration: InputDecoration(
                  prefixText: widget.prefixText,
                  prefixStyle: size16weight500
                      .withHeight(16)
                      .withColor(hasError ? redColor : valueColor),
                  suffixStyle:
                      size16weight500.withHeight(16).withColor(greyScale00),
                  hoverColor: Colors.transparent,
                  filled: true,
                  fillColor: isDisabled
                      ? disabledTextFieldColor
                      : (widget.backgroundColor ?? enabledTextFieldColor),
                  errorMaxLines: 2,
                  contentPadding: widget._noLabel
                      ? null
                      : EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: verticalPadding,
                        ),
                  counterStyle: const TextStyle(
                    height: double.minPositive,
                  ),
                  counterText: '',
                  suffixIcon: _buildSuffixIcon(),
                  prefixIcon: widget.iconAssetName != null
                      ? Container(
                          width: 40.0,
                          margin: const EdgeInsets.only(left: 20.0),
                          alignment: Alignment.centerLeft,
                          child: SvgPicture.asset(
                            'assets/text-field/${widget.iconAssetName}.svg',
                          ),
                        )
                      : widget.prefix,
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide.none,
                  ),
                  labelText:
                      widget._noLabel ? null : (widget.hintText ?? widget.name),
                  labelStyle: size15weight500.copyWith(
                    color: labelColor,
                    height: labelHeight,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                ),
                showErrors: (control) => false,
              ),
            ),
            if (widget.showError)
              Align(
                alignment: Alignment.centerRight,
                child: AnimatedSwitcher(
                  duration: firstDelayDuration,
                  child: () {
                    if (hasError) {
                      return Column(
                        children: [
                          const SizedBox(height: 8.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              errorMessage ?? '',
                              style: size14weight500.withColorHeight(
                                redColor,
                                16.0,
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  }(),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.busy) {
      return const SizedBox(
        width: 32.0,
        height: 32.0,
        child: StyledLoadingIndicator(),
      );
    } else if (widget.suffix != null) {
      return widget.suffix;
    } else if (widget.obscurable) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _obscurable = !_obscurable;
          });
        },
        child: Container(
          width: 32.0,
          margin: const EdgeInsets.only(right: 8.0),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/icons/common/eye-${_obscurable ? 'on' : 'off'}.svg',
          ),
        ),
      );
    } else if (widget.onTap != null &&
        !widget.readOnly &&
        !widget.hideChevronIfVisible) {
      return const Icon(
        Icons.chevron_right,
      );
    }

    return null;
  }
}
