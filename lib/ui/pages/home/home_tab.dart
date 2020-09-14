import 'package:babymoon/models/day.dart';
import 'package:babymoon/models/record.dart';
import 'package:babymoon/services/repositories/day_repository.dart';
import 'package:babymoon/services/repositories/record_repository.dart';
import 'package:babymoon/services/repositories/user_repository.dart';
import 'package:babymoon/ui/pages/add_record_page.dart';
import 'package:babymoon/ui/text_styles.dart';
import 'package:babymoon/ui/widgets/card_layout.dart';
import 'package:babymoon/ui/widgets/home_tab_header.dart';
import 'package:babymoon/utils/notifications_helper.dart';
import 'package:babymoon/utils/records_statistics.dart';
import 'package:babymoon/utils/space.dart';
import 'package:babymoon/ui/widgets/gradient_button.dart';
import 'package:babymoon/ui/widgets/records_in_date.dart';
import 'package:flutter/material.dart';

import '../../app_style.dart';

class HomeTab extends StatefulWidget {

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<Record> _records = [];
  List<DayObj> _days = [];

  Widget _recordsList() {

    List<RecordsInDate> _recordsInDay = [];
    final map = <DateTime, List<Record>>{};

    _records.forEach((record) { 
      final date = record.comparableDate;

      if (!map.containsKey(date)) {
        map[date] = [];
      }
      map[date].add(record);
    });

    map.forEach((date, records) {
      _recordsInDay.add(RecordsInDate(date: date, records: records));
    });
    
    _recordsInDay.sort((a,b) => b.date.compareTo(a.date));

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: map.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: _recordsInDay[index],
        );
      }
    );
  }

  Widget _emptyListDialog() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: CardLayout(
        color: Colors.black.withOpacity(0.3),
        insidePadding: 16,
        child: Text(
          'There is nothing to display...\n'
          'You can add new sleeping record by '
          'clicking on the button above',
          textAlign: TextAlign.center,
          style: TextStyles.main.copyWith(fontSize: 14),
        )
      )
    );
  }

  Widget get _content => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          HomeTabHeader(_records.isEmpty),
          Space(15),
          GradientButton(
            text: 'Add new sleeping record',
            function: _handleAddRecord,
          ),
          Space(20),
          _records.isNotEmpty ? _recordsList() :_emptyListDialog(),
          if (_records.length > 2) Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              height: 40.0,
              width: MediaQuery.of(context).size.width - 80,
              child: RaisedButton(
                onPressed: () => _clearRecords(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)
                ),
                color: AppStyle.backgroundColor.withOpacity(0.2),
                padding: EdgeInsets.all(0.0),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Clear all records',
                    textAlign: TextAlign.center,
                    style: TextStyles.buttonTextStyle.copyWith(
                      color: Colors.red[400].withOpacity(0.8)
                    )
                  ),
                ),
              ),
            )
          )
        ],
      ),
    )
  );

  void _handleAddRecord() async {
    final Record record = await Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
          builder: (context) => AddRecordPage(),
      ),
    );

    if (record != null) {

      final _dayExists = _days
                        .any((d) => d.timestamp == record.comparableDate
                        .millisecondsSinceEpoch);

      if (_days.isEmpty || !_dayExists) {

        await DayRepository.insertDay(DayObj(
          timestamp: record.comparableDate.millisecondsSinceEpoch,
          sleepDuration: record.durationInMinutes
        ));

      } else {
        _days.forEach((d) async {
          if (d.timestamp == record.comparableDate.millisecondsSinceEpoch) {
            d.sleepDuration += record.durationInMinutes;
            await DayRepository.updateDay(d);
          }
        });
      }

      final result = await RecordRepository.insertRecord(record);

      if (result) {
        setState(() {});
      }
    }
  }

  void _clearRecords() async {
    await RecordRepository.deleteAllRecords();
    await DayRepository.deleteAllDays();
    setState(() {});
  }

  void _initializeNotificationsForUser() async {
    final user = await UserRepository.getUser();

    final months = (user.baby.age.years / 12).ceil() + user.baby.age.months;

    if (user.notificationsEnabled) {
      NotificationsHelper.scheduleNotification(
        title: 'Healthy sleep',
        message: "It's perfect time for your baby to go sleep",
        time: RecordsStatistics.getProposedSleepTime(months)
      );
    }
  }
  
  @override
  void initState() {
    _initializeNotificationsForUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        RecordRepository.getAllrecords(50),
        DayRepository.getAllDays()
      ]),      
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _records = snapshot.data[0];
          _days = snapshot.data[1];
          
          return _content;
        } else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }
        return Center(child: CircularProgressIndicator());
      }
    );
  }
}