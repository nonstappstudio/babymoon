import 'package:babymoon/ui/text_styles.dart';
import 'package:babymoon/ui/widgets/card_layout.dart';
import 'package:babymoon/utils/assets.dart';
import 'package:babymoon/utils/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../app_style.dart';

class FirstLaunchPage extends StatelessWidget {

  final PageController _controller = PageController(initialPage: 0);

  static final _fbKey = GlobalKey<FormBuilderState>();
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

  Widget get _nextButton => RaisedButton(
    onPressed: _forward,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    color: AppStyle.backgroundColor.withOpacity(0.7),
    child: Icon(Icons.navigate_next, color: AppStyle.accentColor),
  );

  bool get _validateForm => _fbKey.currentState.validate();

  void _forward() async {
    if (_controller.page == 2) {
      //save
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
      backgroundColor: AppStyle.backgroundColor,
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
                  children: [
                    _welcomeScreen,
                    _babyScreen
                  ],
                ),
              ),
            ),
            Space(64),
            Flexible(
              flex: 1,
              child: _nextButton
            )
          ],
        ),
      ),
    );
  }
}