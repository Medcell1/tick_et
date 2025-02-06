import 'data.dart';

Map<String, String>? emojisForCountryCodes = {
  for (var countryCode in countries.map((e) => e.code).toList())
    countryCode: String.fromCharCode(
          countryCode.runes.first + 0x1F1E6 - 'A'.runes.first,
        ) +
        String.fromCharCode(
          countryCode.runes.last + 0x1F1E6 - 'A'.runes.first,
        ),
};
