import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:ticket_app_flutter/shared/extensions/extensions.dart';
import 'package:ticket_app_flutter/shared/models/phone_country/phone_country.dart';
import 'package:ticket_app_flutter/shared/widgets/phone_number_field/phone_number_field_controller.dart';

import '../../constants/common_form_control_names.dart';
import '../../themes/themes.dart';
import '../styled_widgets/styled_text_field.dart';
import '../view_widgets/picky_list_view.dart';

typedef PhoneNumberFieldPrefixBuilder = Widget? Function(
  BuildContext context,
  Country? country,
);

class PhoneNumberField extends StatefulWidget {
  const PhoneNumberField({
    super.key,
    this.backgroundColor = Colors.transparent,
    this.borderColor = greyScale72,
    this.hintColor = greyScale92,
    this.textColor = greyScale96,
    this.optional = false,
    required this.countryText,
    required this.cancelText,
    required this.controller,
    this.prefixBuilder = _buildPrefix,
    this.onSubmitted,
  });

  final Color? backgroundColor;
  final Color? borderColor;
  final Color? hintColor;
  final Color? textColor;
  final bool optional;
  final String countryText;
  final String cancelText;
  final PhoneNumberController controller;
  final void Function(String)? onSubmitted;
  final PhoneNumberFieldPrefixBuilder prefixBuilder;
  static PhoneNumberFieldPrefixBuilder? defaultPrefixBuilder;

  @override
  PhoneNumberFieldState createState() => PhoneNumberFieldState();

  static Widget? _buildPrefix(BuildContext context, Country? country) {
    return defaultPrefixBuilder != null
        ? defaultPrefixBuilder!(context, country)
        : null;
  }
}

class PhoneNumberFieldState extends State<PhoneNumberField> {
  late final FormGroup _formGroup;

  Future<void> _openCountryPicker({
    required BuildContext context,
    required String title,
  }) async {
    try {
      await PickyListView.showSingle<Country>(
        context: context,
        items: countries,
        title: title,
        cancelText: widget.cancelText,
        groupValue: widget.controller.country,
        closeOnSelect: true,
        onSelected: (Country country) {
          widget.controller.country = country;

          _formGroup.control(CommonFormControlNames.phoneNumber).setValidators([
            Validators.required,
            Validators.minLength(country.length.maxLength),
            Validators.maxLength(country.length.maxLength),
          ]);

          _formGroup
              .control(CommonFormControlNames.phoneNumber)
              .updateValueAndValidity();

          return;
        },
        itemLabelBuilder: (Country country) {
          return country.name;
        },
        leadingBuilder: (Country country) {
          return Row(
            children: [
              Text(
                emojisForCountryCodes![country.code]!,
                style: size16weight700,
              ),
              const SizedBox(width: 8.0),
              SizedBox(
                width: 52.0,
                child: Text(
                  '+${country.prefix}',
                  style: size16weight500,
                ),
              ),
            ],
          );
        },
      );
    } finally {
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _formGroup = FormGroup({
      CommonFormControlNames.country: FormControl<Country>(
        value: widget.controller.country,
        validators: [Validators.required],
      ),
      CommonFormControlNames.phoneNumber: FormControl<String>(
        value: widget.controller.nationalNumber,
        validators: [
          Validators.required,
          Validators.minLength(widget.controller.country!.length.maxLength),
          Validators.maxLength(widget.controller.country!.length.maxLength),
        ],
      ),
    });

    widget.controller.addListener(() {
      _formGroup.patchValue({
        CommonFormControlNames.country: widget.controller.country,
        CommonFormControlNames.phoneNumber: widget.controller.nationalNumber,
      });
    });

    _formGroup.valueChanges.listen((Map<String, dynamic>? value) {
      if (value == null) return;

      widget.controller.country = value[CommonFormControlNames.country];
      widget.controller.nationalNumber =
          value[CommonFormControlNames.phoneNumber];
    });
  }

  @override
  void dispose() {
    _formGroup.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int prefix = widget.controller.country!.prefix;
    final String code = widget.controller.country!.code;
    final String? emoji = emojisForCountryCodes?[code];
    final String country =
        '${emoji.asValidString()} +${prefix.toString().asValidString()}';

    print('BOI -> ${widget.backgroundColor}');

    return ReactiveForm(
      formGroup: _formGroup,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            key: const Key('country_field'),
            onTap: () {
              _openCountryPicker(context: context, title: widget.countryText);
            },
            child: Container(
              height: 58.0,
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 7.0,
              ),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                border: widget.borderColor != null
                    ? Border.all(
                        color: widget.borderColor!,
                      )
                    : null,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 2.0),
                  Text(
                    widget.countryText,
                    style: size12weight500
                        .withColor(widget.hintColor ?? greyScale50)
                        .withHeight(16.0),
                  ),
                  Text(
                    country,
                    style: size16weight500
                        .withColor(widget.textColor ?? greyScale00),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: StyledTextField(
              showError: !widget.optional,
              name: CommonFormControlNames.phoneNumber,
              textInputType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: widget.controller.country?.length.maxLength ?? 15,
              outline: widget.borderColor != null,
              backgroundColor: widget.backgroundColor,
              borderColor: widget.borderColor,
              hintColor: widget.hintColor,
              textColor: widget.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
