import 'package:babymoon/models/user.dart';
import 'package:babymoon/services/repositories/user_repository.dart';
import 'package:babymoon/ui/widgets/error_body.dart';
import 'package:babymoon/utils/notifications_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_permissions/notification_permissions.dart';
import '../../../main.dart';
import '../../app_style.dart';
import '../../text_styles.dart';

class ProfileTab extends StatefulWidget {

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {

  User _user;

  bool _hasChanged;

  bool _notifications;

  Widget get _healthySleep => SwitchListTile(
    value: _notifications,
    title: Text(
      'Sleep time reminder',
      style: TextStyles.main.copyWith(
        fontSize: 16, 
        color: AppStyle.accentColor,
        fontWeight: FontWeight.w200
      ),
    ),
    activeColor: AppStyle.accentColor,
    onChanged: (value) => _onRemindersChanged()
  );

  Widget get _content => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _healthySleep
        ],
      ),
    ),
  );

  void _refresh() {
    setState(() {});
  }

  void _onRemindersChanged() async {
    _hasChanged = true;
    if (_notifications) {
      setState(() => _notifications = false);
    } else {
      if (await _requestPermission()) setState(() => _notifications = true);
      NotificationsHelper.scheduleNotification(
        title: "Bed time",
        message: "It's a perfect sleep time for your baby",
        date: DateTime.now().add(Duration(seconds: 5))
      );
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
  void initState() {
    _hasChanged = false;
    _notifications = false;
    super.initState();
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