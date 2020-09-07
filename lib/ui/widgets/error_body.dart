import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/ui/text_styles.dart';
import 'package:flutter/material.dart';

class ErrorBody extends StatelessWidget {

  final String errorText;
  final Function onRefresh;

  ErrorBody({this.errorText, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: AppStyle.backgroundColor.withOpacity(0.9)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              errorText,
              textAlign: TextAlign.center,
              style: TextStyles.cardTitleStyle
                              .copyWith(color: AppStyle.accentColor)
            ),
            if (onRefresh != null) Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: IconButton(
                onPressed: () => onRefresh(),
                icon: Icon(Icons.refresh, color: AppStyle.accentColor, size: 36)
              ),
            ),
          ],
        )
      ),
    );
  }
}