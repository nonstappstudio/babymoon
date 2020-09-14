import 'package:babymoon/models/user.dart';
import 'package:babymoon/services/repositories/user_repository.dart';
import 'package:babymoon/ui/widgets/card_layout.dart';
import 'package:babymoon/ui/widgets/error_body.dart';
import 'package:babymoon/utils/notifications_helper.dart';
import 'package:babymoon/utils/records_statistics.dart';
import 'package:babymoon/utils/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:notification_permissions/notification_permissions.dart';
import '../../app_style.dart';
import '../../text_styles.dart';

class ProfileTab extends StatefulWidget {

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {

  static final _switchKey = GlobalKey<FormBuilderState>();

  User _user;

  Widget get _healthySleep => SwitchListTile(
    value: _user.notificationsEnabled,
    title: Text(
      'Healthy sleep',
      style: TextStyles.main.copyWith(
        fontSize: 16, 
        color: AppStyle.accentColor,
        fontWeight: FontWeight.w400
      ),
    ),
    activeColor: AppStyle.accentColor,
    onChanged: (value) => _onRemindersChanged(value)
  );

  Widget get _content => Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        _notificationPreferences
      ],
    ),
  );

  Widget get _notificationPreferences => SingleChildScrollView(
    child: CardLayout(
      color: AppStyle.backgroundColor.withOpacity(0.7),
      insidePadding: 16,
      child: FormBuilder(
        key: _switchKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.notifications_active, 
                color: AppStyle.accentColor, 
                size: 54
              )
            ),
            Space(16),
            Center(
              child: Text(
                'Healthy sleep',
                style: TextStyles.appBarStyle.copyWith(fontSize: 26),
                textAlign: TextAlign.center,
              ),
            ),
            Space(24),
            Text(
              "Get proposed sleep time reminders based on your baby's age"
              " \n&\nprofessional doctors",
              style: TextStyles.appBarStyle
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w200),
              textAlign: TextAlign.center,
            ),
            Space(8),
            _healthySleep
          ],
        ),
      ),
    ),
  );

  void _refresh() {
    setState(() {});
  }

  void _onRemindersChanged(bool value) async {

    final permissionStatus = await NotificationPermissions
          .getNotificationPermissionStatus();

    if (_user.notificationsEnabled) {
      
      NotificationsHelper.cancelAllNotifications();

      _user.notificationsEnabled = false;
      await UserRepository.updateUser(_user);
      _refresh();

    } else {

      if (permissionStatus == PermissionStatus.granted) {
        _user.notificationsEnabled = true;
        await UserRepository.updateUser(_user);
        _refresh();

        final months = (_user.baby.age.years / 12)
                       .ceil() + _user.baby.age.months;

        NotificationsHelper.scheduleNotification(
          title: 'Healthy sleep',
          message: "It's perfect time for your baby to go sleep",
          time: RecordsStatistics.getProposedSleepTime(months)
        );
      } else {
        showDialog(
          context: context, 
          barrierDismissible: true,
          builder: (c) => AlertDialog(
            title: Text(
              'Permission required',
              style: TextStyles.main.copyWith(
                color: AppStyle.blueyColor,
                fontSize: 18
              ),
            ),
            content: Text(
              'To enable this feature,\n'
              'notifications permission must be granted',
              style: TextStyles.errorStyle,
            ),
            actions: [
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: AppStyle.blueyColor, width: 1)
                ),
                onPressed: () async {
                  final result = await _requestPermission();

                  if (result != null) {
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  'Grant permission',
                  style: TextStyles.main.copyWith(
                    color: AppStyle.blueyColor,
                    fontWeight: FontWeight.normal
                  )
                ),
              )
            ],
          )
        );
      }
    }
  }

  Future<bool> _requestPermission() async {
    final permissionStatus = await NotificationPermissions
                  .getNotificationPermissionStatus();

    if (permissionStatus != PermissionStatus.granted) {

      final bool _openSettings = permissionStatus == PermissionStatus.denied;

      final result = await NotificationPermissions
          .requestNotificationPermissions(openSettings: _openSettings);

      return result == PermissionStatus.granted;
    } else if (permissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: UserRepository.getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          _user = snapshot.data;

          return _content;

        } else if (snapshot.hasError) {

          return ErrorBody(
            errorText: 'Error while getting profile', 
            onRefresh: _refresh
          );

        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}