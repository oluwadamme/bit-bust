import 'package:intl/intl.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }

  double toDouble() {
    final double? val = double.tryParse(replaceAll(",", ""));
    return val ?? 0;
  }

  String get capitalize => "${this[0].toUpperCase()}${substring(1).toLowerCase()}";

  String get capitalizeFirstofEach => split(" ").map((str) => str.capitalize).join(" ");

  String get addCommas => replaceAllMapped(
        RegExp(
          r'(?<!\.\d*)(\d{1,3})(?=(\d{3})+(?!\d))',
        ),
        (Match m) => '${m[1]},',
      );

  String get replaceBrackets => replaceAll(RegExp(r'/\[|\]/g'), '');
}

// ignore: camel_case_extensions
extension dateFlex on DateTime {
  String dateString() => DateFormat('dd-MM-yyyy').format(this);
  String toDateString() {
    return DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(this);
  }
}

extension IntParser on int {
  double parseInt() => toDouble();
}

extension MoneyFormat on double {
  String toNaira() {
    return fmt.format(this);
  }
}

final fmt = NumberFormat("#,##0.00", "en_US");

extension Dates on DateTime {
  String toDateString() {
    return DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY).format(this);
  }

  String toFullDateString() {
    return "${DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY).format(this)} ${DateFormat(DateFormat.HOUR_MINUTE).format(this)}";
  }

  bool isSameDay(DateTime dateTime) {
    return (dateTime.day == day) && (dateTime.month == month) && (dateTime.year == year);
  }
}
