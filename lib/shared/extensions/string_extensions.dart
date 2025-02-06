extension NullableStringX on String? {
  String get initials {
    if (this == null) {
      return 'N/A';
    }

    final List<String> split = this!.split(' ').where((e) {
      return e.trim() != '';
    }).toList();

    if (split.length == 1) {
      return split[0].substring(0, 2).toUpperCase();
    }

    return '${split[0].substring(0, 1).toUpperCase()}${split[1].substring(0, 1).toUpperCase()}';
  }

  DateTime? get toDateTime {
    return DateTime.tryParse(this ?? '');
  }

  /// Returns true if the trimmed version of this [String] is not null, not empty, and not "null".
  ///
  /// Example:
  ///
  /// ```dart
  /// '  Hello, world!  '.isValidString; // Returns true
  /// '  '.isValidString; // Returns false
  /// ''.isValidString; // Returns false
  /// null.isValidString; // Returns false
  /// 'null'.isValidString; // Returns false
  /// 'Null'.isValidString; // Returns false
  /// ```
  bool get isValidString {
    return this != null &&
        this!.trim().isNotEmpty &&
        this!.trim().toLowerCase() != 'null';
  }

  /// Returns this [String] if it is a valid string (not null, not empty, not "null", "Null"),
  /// or returns the specified fallback string.
  ///
  /// Example:
  ///
  /// ```dart
  /// '  Hello, world!  '.asValidString(); // Returns 'Hello, world!'
  /// '  '.asValidString(); // Returns 'N/A'
  /// ''.asValidString(); // Returns 'N/A'
  /// null.asValidString(); // Returns 'N/A'
  /// 'null'.asValidString(); // Returns 'N/A'
  /// 'Null'.asValidString(); // Returns 'N/A'
  /// ```
  ///
  /// You can also provide a custom fallback string:
  ///
  /// ```dart
  /// '  '.asValidString('Not available'); // Returns 'Not available'
  /// ```
  String asValidString([String fallback = 'N/A']) {
    return isValidString ? this! : fallback;
  }
}

extension StringX on String {
  // String get translate {
  //   return this.tr();
  // }
  //
  // String translateWith({
  //   required Map<String, String>? namedArgs,
  // }) {
  //   return this.tr(namedArgs: namedArgs);
  // }

  DateTime get toDateTime {
    return DateTime.parse(this);
  }
}
