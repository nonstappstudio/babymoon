import 'package:babymoon/models/baby.dart';
import 'package:babymoon/models/user.dart';
import 'package:babymoon/services/repositories/user_repository.dart';
import 'package:babymoon/ui/pages/home_page.dart';
import 'package:babymoon/ui/text_styles.dart';
import 'package:babymoon/ui/widgets/card_layout.dart';
import 'package:babymoon/utils/assets.dart';
import 'package:babymoon/utils/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:notification_permissions/notification_permissions.dart' as np;
import 'package:permission_handler/permission_handler.dart';
import '../app_style.dart';

class FirstLaunchPage extends StatelessWidget {

  final PageController _controller = PageController(initialPage: 0);

  static final _fbKey = GlobalKey<FormBuilderState>();
  static final _switchKey = GlobalKey<FormBuilderState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  Widget get _welcomeScreen => SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Space(64),
        Center(
          child: ImageIcon(Assets.toy, color: AppStyle.accentColor, size: 64)
        ),
        Space(24),
        Center(
          child: Text(
            'Welcome to babymoon',
            style: TextStyles.appBarStyle.copyWith(fontSize: 26),
            textAlign: TextAlign.center,
          ),
        ),
        Space(48),
        Text(
          'Please give us some necessary information so that '
          'we can customize the application especially for you',
          style: TextStyles.appBarStyle
              .copyWith(fontSize: 18, fontWeight: FontWeight.w200),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );

  Widget get _babyScreen => SingleChildScrollView(
    child: FormBuilder(
      key: _fbKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Space(64),
          Center(
            child: ImageIcon(Assets.baby, color: AppStyle.accentColor, size: 64)
          ),
          Space(24),
          Center(
          child: Text(
            'Baby card',
              style: TextStyles.appBarStyle.copyWith(fontSize: 26),
              textAlign: TextAlign.center,
            ),
          ),
          Space(24),
          FormBuilderTextField(
            attribute: 'name',
            controller: _nameController,
            maxLines: 1,
            style: TextStyles.main,
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: TextStyles.main,
              errorStyle: TextStyles.errorStyle,
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppStyle.accentColor)
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppStyle.accentColor)
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppStyle.accentColor)
              ),
              prefixIcon: Icon(Icons.face, color: AppStyle.accentColor)
            ),
            validators: [
              FormBuilderValidators.required(
                errorText: 'I need a name :('
              )
            ],
          ),
          Space(24),
          FormBuilderDateTimePicker(
            attribute: 'birthday',
            inputType: InputType.date,
            resetIcon: Icon(Icons.close, color: AppStyle.accentColor),
            maxLines: 1,
            firstDate: DateTime(
              DateTime.now().year - 50,
              DateTime.now().month,
              DateTime.now().day
            ),
            lastDate: DateTime.now(),
            style: TextStyles.main,
            controller: _birthdayController,
            decoration: InputDecoration(
              labelText: 'Birthday',
              labelStyle: TextStyles.main,
              errorStyle: TextStyles.errorStyle,
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppStyle.accentColor)
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppStyle.accentColor)
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppStyle.accentColor)
              ),
              prefixIcon: Icon(Icons.cake, color: AppStyle.accentColor)
            ),
            validators: [
              FormBuilderValidators.required(
                errorText: 'Please set my age :('
              )
            ]
          )
        ],
      ),
    ),
  );

  Widget get _preferencesScreen => SingleChildScrollView(
    child: FormBuilder(
      key: _switchKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Space(64),
          Center(
            child: Icon(
              Icons.notifications_active, 
              color: AppStyle.accentColor, 
              size: 54
            )
          ),
          Space(24),
          Center(
            child: Text(
              'Healthy sleep',
              style: TextStyles.appBarStyle.copyWith(fontSize: 26),
              textAlign: TextAlign.center,
            ),
          ),
          Space(48),
          Text(
            "Get proposed sleep time reminders based on your baby's age"
            " \n&\nprofessional doctors",
            style: TextStyles.appBarStyle
                .copyWith(fontSize: 18, fontWeight: FontWeight.w200),
            textAlign: TextAlign.center,
          ),
          Space(24),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: FormBuilderSwitch(
              attribute: 'notifications',
              initialValue: true,
              label: Text(
                'Healthy sleep',
                style: TextStyles.main.copyWith(
                  fontSize: 16, 
                  color: AppStyle.accentColor,
                  fontWeight: FontWeight.w200
                ),
              ),
              decoration: InputDecoration(
                border: InputBorder.none
              ),
              activeColor: AppStyle.accentColor,
              onChanged: (value) => _onRemindersChanged(value)
            ),
          ),
        ],
      ),
    ),
  );

  Widget _nextButton(BuildContext context) {
    return RaisedButton(
      onPressed: () => _forward(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: AppStyle.backgroundColor.withOpacity(0.7),
      child: Icon(Icons.navigate_next, color: AppStyle.accentColor),
    );
  }

  void _onRemindersChanged(bool value) async {
    if (!value) {
      await np.NotificationPermissions
          .getNotificationPermissionStatus();
    } else {
      await _requestPermission();
    }
  }

  Future<bool> _requestPermission() async {
    final permissionStatus = await np.NotificationPermissions
                  .getNotificationPermissionStatus();

    if (permissionStatus != np.PermissionStatus.granted) {

      final bool _openSettings = permissionStatus == np.PermissionStatus.denied;

      final result = await np.NotificationPermissions
          .requestNotificationPermissions(openSettings: _openSettings);

      return result == np.PermissionStatus.granted;
    } else if (permissionStatus == np.PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  bool get _validateForm => _fbKey.currentState.validate();

  Future<bool> get _permissionVariable async {
    final permissionStatus = await np.NotificationPermissions
          .getNotificationPermissionStatus();
    
    if (permissionStatus == np.PermissionStatus.denied) {

      await np.NotificationPermissions.requestNotificationPermissions();
      return await np.NotificationPermissions
        .getNotificationPermissionStatus() == np.PermissionStatus.granted;

    } else {

      await Permission.notification.request();
      return await Permission.notification.status == PermissionStatus.granted;

    }
  }

  void _forward(BuildContext context) async {
    if (_controller.page == 3) {
      //save
    } else if (_controller.page == 2) {

      final user = User(
          baby: Baby(
            birthday: DateTime.parse(_birthdayController.text.trim()),
            name: _nameController.text.trim()
          ),
          cashCount: 0,
          id: DateTime.now().millisecondsSinceEpoch,
          isPremium: false,
          notificationsEnabled: await _permissionVariable
        );

      final result = await UserRepository.insertUser(user);

      if (result != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (c) => HomePage()
          )
        );
      }

    } else if (_controller.page == 1) {

      if (_validateForm) _goToNext();

    } else {
      
      _goToNext();
    }
  }

  void _goToNext() {
    _controller.animateToPage(
      _controller.page.toInt() + 1, 
      duration: Duration(milliseconds: 150), 
      curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.blueyColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppStyle.backgroundColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/night.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: CardLayout(
                color: AppStyle.backgroundColor.withOpacity(0.7),
                insidePadding: 16,
                child: PageView(
                  controller: _controller,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    _welcomeScreen,
                    _babyScreen,
                    _preferencesScreen,
                  ],
                ),
              ),
            ),
            Space(64),
            Flexible(
              flex: 1,
              child: _nextButton(context)
            )
          ],
        ),
      ),
    );
  }
}