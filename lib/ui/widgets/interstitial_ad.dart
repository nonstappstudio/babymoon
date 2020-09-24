import 'package:babymoon/ui/text_styles.dart';
import 'package:babymoon/utils/assets.dart';
import 'package:babymoon/utils/space.dart';
import 'package:flutter/material.dart';

import '../app_style.dart';

class InterstitialAd extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppStyle.blueyColor,
      actions: [
        FlatButton(
          child: Text(
            'Close', 
            style: TextStyle(fontWeight: FontWeight.w400)
          ),
          textColor: AppStyle.accentColor,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        RaisedButton(
          child: Text(
            'Remove ads', 
            style: TextStyle(fontWeight: FontWeight.w600)
          ),
          color: AppStyle.accentColor,
          textColor: AppStyle.blueyColor,
          onPressed: () => Navigator.of(context).pop(true),
        )
      ],
      content: Container(
        height: 220,
        child: Column(
          children: [
            Center(
              child: ImageIcon(
                Assets.removeAds, 
                color: AppStyle.accentColor, 
                size: 50
              )
            ),
            Space(16),
            Center(
              child: Text(
                'Remove ads',
                style: TextStyles.appBarStyle.copyWith(fontSize: 26),
                textAlign: TextAlign.center,
              ),
            ),
            Space(24),
            Text(
              'For better experience, remove all ads from the application.',
              style: TextStyles.appBarStyle
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w200),
              textAlign: TextAlign.center,
            ),
            Space(8),
            Text(
              'Now, just for',
              style: TextStyles.appBarStyle
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            Space(4),
            Text(
              '0.99\$ ',
              style: TextStyles.appBarStyle
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}