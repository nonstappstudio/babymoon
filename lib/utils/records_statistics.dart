import 'package:babymoon/models/day.dart';
import 'package:babymoon/models/record.dart';

class RecordsStatistics {

  static double getProposedHours(int months) {
    
    if (months >= 50) {
      return 8;
    } else if (months >= 48) {
      return 11;
    } else if (months >= 36) {
      return 12;
    } else if (months >= 24) {
      return 13;
    } else if (months >= 18) {
      return 13.5;
    } else if (months >= 12) {
      return 14;
    } else if (months >= 9) {
      return 14;
    } else if (months >= 6) {
      return 14;
    } else if (months >= 3) {
      return 15;
    } else if (months >= 1) {
      return 15.5;
    } else {
      return 16;
    }

  }

  static String averageSleepDuration(List<DayObj> days) {

    int total = 0;

    days.forEach((d) { 
      total += d.sleepDuration;
    });

    final avg = (total / days.length).ceil();
    final duration = Duration(minutes: avg);

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(avg.remainder(60));
    return '${twoDigits(duration.inHours)}h ${twoDigitMinutes}m';

  }

  static String averageFromRecords(List<Record> records) {

    int total = 0;

    records.forEach((r) { 
      total += r.durationInMinutes;
    });

    final avg = (total / records.length).ceil();
    final duration = Duration(minutes: avg);

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(avg.remainder(60));
    return '${twoDigits(duration.inHours)}h ${twoDigitMinutes}m';
  }
}