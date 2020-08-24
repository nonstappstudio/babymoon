import 'package:babymoon/ui/models/record.dart';
import 'package:babymoon/ui/pages/add_record_page.dart';
import 'package:babymoon/ui/widgets/home_tab_header.dart';
import 'package:babymoon/utils/space.dart';
import 'package:babymoon/ui/widgets/gradient_button.dart';
import 'package:babymoon/ui/widgets/records_in_date.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  List<Record> _records = [];

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
        return _recordsInDay[index];
      }
    );
  }

  Widget _emptyListDialog() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Text(
        'There is nothing to display...\n'
        'You can add new sleeping record by clicking on the button above',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryColor

        ),
      ),
    );
  }

  void _handleAddRecord() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
          builder: (context) => AddRecordPage(),
      ),
    );

    if(result != null){
      setState(() {
        _records.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            HomeTabHeader(),
            Space(15),
            GradientButton(
              text: 'Add new sleeping record',
              function: _handleAddRecord,
            ),
            Space(20),
            _records.isNotEmpty ? _recordsList() :_emptyListDialog()
          ],
        ),
      )
    );
  }
}