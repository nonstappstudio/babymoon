import 'package:audioplayer/audioplayer.dart';
import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/ui/text_styles.dart';
import 'package:babymoon/ui/widgets/card_layout.dart';
import 'package:babymoon/utils/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LullabiesTab extends StatefulWidget {

  @override
  _LullabiesTabState createState() => _LullabiesTabState();
}

class _LullabiesTabState extends State<LullabiesTab> {

  final audioPlayer = AudioPlayer();

  int _currentLullaby = 0;

  Map<String, String> get _lullabies => {
    'Twinkle, Twinkle Little Star': 'https://www.johnsonsbaby.co.za/sites/jbaby_menap/files/twinkle.mp3',
    'Lullaby Goodnight':'https://www.johnsonsbaby.co.za/sites/jbaby_menap/files/lullabygoodnight.mp3',
    'All The Pretty Horses':'https://www.johnsonsbaby.co.za/sites/jbaby_menap/files/prettylittlehorses.mp3',
    'Rock a Bye Baby':'https://www.johnsonsbaby.co.za/sites/jbaby_menap/files/rockabyebaby.mp3'
  };

  bool _isRepeat;

  Widget _leadingIcon(int index) {

    final isPlay = _currentLullaby == index;

      return IconButton(
        onPressed: () {
          if (isPlay) {
            _currentLullaby = null;
            _pause();
          } else {
            _currentLullaby = index;
            _play();
          }
        },
        icon: Icon(
          isPlay ? Icons.pause : Icons.play_arrow, 
          color: Colors.white
        )
      );
  }

  Widget _trailingIcon(index) {
    final bool isCurrent = _currentLullaby == index;

    if (isCurrent) {
      return IconButton(
        onPressed: () => setState(() => _isRepeat == !_isRepeat),
        icon: Icon(
          Icons.repeat, 
          color: _isRepeat ? AppStyle.accentColor : AppStyle.unselectedColor
        ),
      );
    } else {
      return Container(width: 0);
    }
  }

  void _play() async {
    await audioPlayer.play(_lullabies.values.toList()[_currentLullaby]);
    setState(() {});
  }

  void _pause() async {
    await audioPlayer.pause();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _isRepeat = false;
    _currentLullaby = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Space(16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Lullabies provided by Johnson's baby",
              style: TextStyles.main,
            ),
          ),
          Space(64),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (_,__) => Divider(
                height: 16, 
                color: Colors.transparent
              ),
              itemCount: _lullabies.keys.length,
              itemBuilder: (context, index) {
                
                return CardLayout(
                  insidePadding: 8,
                  color: AppStyle.backgroundColor.withOpacity(0.7),
                  child: ListTile(
                    leading: _leadingIcon(index),
                    title: Text(
                      _lullabies.keys.toList()[index],
                      style: TextStyles.mainWhite,
                    ),
                    //trailing: _trailingIcon(index)
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}