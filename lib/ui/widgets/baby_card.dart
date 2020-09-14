import 'package:babymoon/models/baby.dart';
import 'package:babymoon/utils/assets.dart';
import 'package:babymoon/utils/space.dart';
import 'package:flutter/material.dart';
import '../app_style.dart';
import '../text_styles.dart';
import 'card_layout.dart';

class BabyCard extends StatelessWidget {

  final Baby baby;

  BabyCard([this.baby]);

    String get _ageDayString => baby.age.days == 1
          ? '1 day' 
          : '${baby.age.days} days';

  String get _ageMonthString => baby.age.months == 1
          ? '1 month'
          : '${baby.age.months} months';

  String get _ageYearString => baby.age.years == 1
          ? '1 year'
          : '${baby.age.years} years';

  String get _babyAge {
    final age = baby.age;

    if (age.years == 0 && age.months == 0) {

      // return just days
      return _ageDayString == '' ? 'Baby born today :)' : _ageDayString;

    } else if (age.years == 0) {

      // return months and days
      return '$_ageMonthString';

    } else {
      return '$_ageYearString & $_ageMonthString';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      insidePadding: 16,
      color: Colors.white.withOpacity(0.75),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 48.0),
              child: ImageIcon(
                Assets.baby,
                color: AppStyle.blueyColor,
                size: 65,
              ),
            ),
          ),
          Space(24),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  baby.name,
                  textAlign: TextAlign.start,
                  style: TextStyles.whiteBoldText.copyWith(
                    color: AppStyle.blueyColor,
                    fontSize: 21
                  ),
                ),
                Space(4),
                Text(
                  'Age: $_babyAge',
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  style: TextStyles.cardContentStyle,
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}