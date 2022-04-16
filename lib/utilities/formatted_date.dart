import 'package:intl/intl.dart';

class FormattedDate {
  static String getFormattedDate(DateTime dateTime) {
    return DateFormat('EEEE | MMM d').format(dateTime);
  }
}
