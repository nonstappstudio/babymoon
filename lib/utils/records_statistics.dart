import 'package:babymoon/models/day.dart';
import 'package:babymoon/models/record.dart';

class RecordsStatistics {

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