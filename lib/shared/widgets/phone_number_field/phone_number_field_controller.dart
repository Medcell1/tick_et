import 'package:flutter/widgets.dart';
import 'package:ticket_app_flutter/shared/models/phone_country/phone_country.dart';

class PhoneNumberController extends ChangeNotifier
    implements ValueNotifier<PhoneNumber?> {
  PhoneNumberController([PhoneNumber value = PhoneNumber.empty])
      : nationalNumberController = TextEditingController(
          text: value.nationalNumber,
        ),
        countryNotifier = ValueNotifier(value.country),
        _value = value,
        super() {
    _initialize();
  }

  PhoneNumberController.fromCountry(Country country)
      : nationalNumberController = TextEditingController(),
        countryNotifier = ValueNotifier(country),
        _value = PhoneNumber.empty.copyWith(country: country) {
    _initialize();
  }

  factory PhoneNumberController.fromCountryCode(String isoCode) =>
      PhoneNumberController.fromCountry(Country.fromCode(isoCode));

  final TextEditingController nationalNumberController;
  final ValueNotifier<Country?> countryNotifier;

  Country? get country => countryNotifier.value;
  set country(Country? newValue) {
    countryNotifier.value = newValue;
  }

  String get nationalNumber => nationalNumberController.text;
  set nationalNumber(String newValue) {
    nationalNumberController.text = newValue;
  }

  @override
  set value(PhoneNumber? newValue) {
    if (value == newValue) return;
    _value = newValue;
    notifyListeners();
    _detach();
    try {
      countryNotifier.value = newValue?.country;
      nationalNumberController.text = newValue?.nationalNumber ?? '';
    } finally {
      _attach();
    }
  }

  @override
  PhoneNumber? get value => _value;

  @override
  void dispose() {
    _detach();
    countryNotifier.dispose();
    nationalNumberController.dispose();
    super.dispose();
  }

  PhoneNumber? _value;

  void _attach() {
    countryNotifier.addListener(_onChange);
    nationalNumberController.addListener(_onChange);
  }

  void _detach() {
    countryNotifier.removeListener(_onChange);
    nationalNumberController.removeListener(_onChange);
  }

  void _initialize() {
    _attach();
  }

  void _onChange() {
    _value = PhoneNumber(country, nationalNumber);
    notifyListeners();
  }
}
