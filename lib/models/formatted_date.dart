import 'package:intl/intl.dart';

class FormattedDate {
  static String getFormattedDate(DateTime dateTime) {
    return DateFormat('EEEE | MMM d').format(dateTime);
  }
}

class FormattedDay {
  static String getFormattedDate(DateTime dateTime) {
    return DateFormat('E').format(dateTime);
  }
}

class FormattedHours {
  static String getFormattedHours(DateTime hours) {
    return DateFormat('Hm').format(hours);
  }
}
