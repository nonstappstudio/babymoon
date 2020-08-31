import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/ui/text_styles.dart';
import 'package:babymoon/ui/widgets/card_layout.dart';
import 'package:babymoon/utils/space.dart';
import 'package:flutter/material.dart';

class StatisticsTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CardLayout(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 80),
                    Space(24),
                    Text(
                      'Baby age: 12 months',
                      style: TextStyles.whiteBoldText,
                    ),
                  ],
                ),
              ),
              color: AppStyle.backgroundColor.withOpacity(0.6),
              insidePadding: 16,
            ),
            Space(16),
            CardLayout(
              child: Text(
                'Overal sleep time',
                style: TextStyles.mainWhite,
              ),
              color: AppStyle.backgroundColor.withOpacity(0.8),
              insidePadding: 16,
            ),
            Space(24),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CardLayout(
                    child: Center(
                      child: Text('data 1')
                    ),
                    color: AppStyle.backgroundColor.withOpacity(0.8),
                    insidePadding: 16,
                  )
                ),
                Space(8),
                Expanded(
                  flex: 1,
                  child: CardLayout(
                    child: Center(
                      child: Text(
                        'Data 2',
                        style: TextStyles.mainWhite,
                      )
                    ),
                    color: AppStyle.backgroundColor.withOpacity(0.8),
                    insidePadding: 16,
                  )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}