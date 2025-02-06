import 'package:intl/intl.dart';
import 'package:ticket_app_flutter/shared/extensions/extensions.dart';

extension CustomDateTimeExtensions on DateTime? {
  String get asReadableDate {
    return this == null
        ? ''.asValidString()
        : DateFormat(
            'dd.MM.yyyy',
          ).format(this!);
  }

  String asFriendlyDate({bool includeYear = true}) {
    return this == null
        ? ''.asValidString()
        : DateFormat('d MMM${includeYear ? ' yyyy' : ''}').format(
            this!,
          );
  }

  String asFriendlyDateTime({bool includeYear = true}) {
    return this == null
        ? ''.asValidString()
        : DateFormat('🗓️ d MMM${includeYear ? ' yyyy ⏰ HH:mm' : ''}').format(
            this!,
          );
  }

  DateTime? get dateOnly {
    return this == null
        ? null
        : DateTime(
            this!.year,
            this!.month,
            this!.day,
          );
  }

  String get asFormattedTime {
    return this == null
        ? ''.asValidString()
        : DateFormat('HH:mm').format(this!);
  }
}
