import 'package:babymoon/models/record.dart';
import 'package:babymoon/models/user.dart';
import 'package:babymoon/services/repositories/record_repository.dart';
import 'package:babymoon/services/repositories/user_repository.dart';
import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/ui/text_styles.dart';
import 'package:babymoon/ui/widgets/card_layout.dart';
import 'package:babymoon/ui/widgets/circle_border_view.dart';
import 'package:babymoon/ui/widgets/error_body.dart';
import 'package:babymoon/utils/assets.dart';
import 'package:babymoon/utils/records_statistics.dart';
import 'package:babymoon/utils/space.dart';
import 'package:flutter/material.dart';

class StatisticsTab extends StatefulWidget {

  @override
  _StatisticsTabState createState() => _StatisticsTabState();
}

class _StatisticsTabState extends State<StatisticsTab> {

  List<Record> records = [];
  User user;
  
  @override
  void initState() {
    super.initState();
  }

  Widget _content(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CardLayout(
              insidePadding: 16,
              color: Colors.white.withOpacity(0.75),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: ImageIcon(
                      Assets.baby,
                      color: AppStyle.blueyColor,
                      size: 54,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      children: [
                        Text(
                          user.baby.name,
                          textAlign: TextAlign.center,
                          style: TextStyles.whiteBoldText
                                .copyWith(color: AppStyle.blueyColor),
                        ),
                        Space(12),
                        Text(
                          'Overal sleep condition: 9.6',
                          textAlign: TextAlign.center,
                          style: TextStyles.cardContentStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),
            Space(8.0),
            CardLayout(
              insidePadding: 16,
              color: Colors.white.withOpacity(0.75),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      'Average sleep time per day',
                      textAlign: TextAlign.center,
                      style: TextStyles.whiteBoldText
                            .copyWith(color: AppStyle.blueyColor),
                    ),
                    Space(12),
                    CircleBorderView(
                      child: Text(
                        '${RecordsStatistics
                        .averageSleepDuration(records)}',
                        textAlign: TextAlign.center,
                        style: TextStyles.cardContentStyle,
                      ),
                    )
                  ],
                ),
              )
            ),
            Space(4),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CardLayout(
                    insidePadding: 16,
                    color: Colors.white.withOpacity(0.75),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Text(
                            "Night's sleep",
                            textAlign: TextAlign.center,
                            style: TextStyles.whiteBoldText
                                  .copyWith(color: AppStyle.blueyColor),
                          ),
                          Space(12),
                          CircleBorderView(
                            child: Text(
                              '${RecordsStatistics
                              .averageNightSleepDuration(records)}',
                              textAlign: TextAlign.center,
                              style: TextStyles.cardContentStyle,
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                ),
                Space(4),
                Expanded(
                  flex: 1,
                  child: CardLayout(
                    insidePadding: 16,
                    color: Colors.white.withOpacity(0.75),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Text(
                            'Naps',
                            textAlign: TextAlign.center,
                            style: TextStyles.whiteBoldText
                                  .copyWith(color: AppStyle.blueyColor),
                          ),
                          Space(12),
                          CircleBorderView(
                            child: Text(
                              '${RecordsStatistics
                              .averageNapsDuration(records)}',
                              textAlign: TextAlign.center,
                              style: TextStyles.cardContentStyle,
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  } 

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        RecordRepository.getAllrecords(),
        UserRepository.getUser()
      ]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          
          records = snapshot.data[0];

          user = snapshot.data[1];

          return _content(context);

        } else if (snapshot.hasError) {

          return ErrorBody(
            errorText: 'Error while getting statistics',
            onRefresh: () => setState(() {print('refresh');})
          );


        }
        return Center(
          child: CircularProgressIndicator()
        );
      },
    );
  }
}