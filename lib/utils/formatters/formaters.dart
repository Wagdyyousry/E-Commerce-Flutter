import 'package:intl/intl.dart';

class MyFormatters {
  static String fromDateToDayesMonthsYears(int dateTime) {
    final DateFormat df = DateFormat("dd-MM-yyyy hh:mm a");
    final timeSinceEpoch = DateTime.fromMillisecondsSinceEpoch(dateTime);
    final String releaseDate = df.format(timeSinceEpoch);
    return releaseDate;
  }

  static String fromDateToDayesMonths(int dateTime) {
    final DateFormat df = DateFormat("dd-MM hh:mm a");
    final timeSinceEpoch = DateTime.fromMillisecondsSinceEpoch(dateTime);
    final String releaseDate = df.format(timeSinceEpoch);
    return releaseDate;
  }

  static String fromDateToDayes(int dateTime) {
    final DateFormat df = DateFormat("dd hh:mm a");
    final timeSinceEpoch = DateTime.fromMillisecondsSinceEpoch(dateTime);
    final String releaseDate = df.format(timeSinceEpoch);
    return releaseDate;
  }

}
