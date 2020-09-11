import 'package:babymoon/models/record.dart';

class RecordsStatistics {

  static String averageSleepDuration(List<Record> records, int daysPast) {

    int totalInMinutes = 0;
    Map<DateTime, int> _sleepMinutesInDate = {};  

  
    // for (int i = 0; i < daysPast; i++) {
    //   totalInMinutes += records[i].durationInMinutes;
    // }

    //TODO: divide by days not records, because there are also naps
    totalInMinutes = (totalInMinutes / records.length).ceil();

    Duration total = Duration(minutes: totalInMinutes);

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(total.inMinutes.remainder(60));
    return '${twoDigits(total.inHours)}h ${twoDigitMinutes}m';

  }

  static String averageNightSleepDuration(List<Record> records) {

    Duration total = Duration(minutes: 0);

    records.where((r) => r.type == SleepType.NIGHTS_SLEEP).forEach((r) { 
      total += Duration(minutes: r.durationInMinutes);
    });

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(total.inMinutes.remainder(60));
    return '${twoDigits(total.inHours)}h ${twoDigitMinutes}m';
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