import 'dart:async';

import 'package:audioplayer/audioplayer.dart';
import 'package:babymoon/ui/app_style.dart';
import 'package:babymoon/ui/text_styles.dart';
import 'package:babymoon/ui/widgets/card_layout.dart';
import 'package:babymoon/utils/space.dart';
import 'package:flutter/material.dart';

class LullabiesTab extends StatefulWidget {

  @override
  _LullabiesTabState createState() => _LullabiesTabState();
}

class _LullabiesTabState extends State<LullabiesTab> {

  final audioPlayer = AudioPlayer();

  bool get _isInitialized => audioPlayer.state == AudioPlayerState.PAUSED
                          || audioPlayer.state == AudioPlayerState.PLAYING
                          || audioPlayer.state == AudioPlayerState.COMPLETED;

  int _currentLullaby = 0;

  Map<String, String> get _lullabies => {
    'Twinkle, Twinkle Little Star': 'https://www.johnsonsbaby.co.za/sites/jbaby_menap/files/twinkle.mp3',
    'Lullaby Goodnight':'https://www.johnsonsbaby.co.za/sites/jbaby_menap/files/lullabygoodnight.mp3',
    'All The Pretty Horses':'https://www.johnsonsbaby.co.za/sites/jbaby_menap/files/prettylittlehorses.mp3',
    'Rock a Bye Baby':'https://www.johnsonsbaby.co.za/sites/jbaby_menap/files/rockabyebaby.mp3'
  };

  String _minutesSafeString(Duration duration) {

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitsSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}h ${twoDigitsSeconds}m';
  }

  Duration _position;

  StreamSubscription _positionSubscription;

  Widget get _playerController => CardLayout(
    insidePadding: 16.0,
    color: AppStyle.backgroundColor.withOpacity(0.7),
    child: Row(
      children: [
        Flexible(
          flex: 1,
          child: IconButton(
            onPressed: () {
              audioPlayer.state == AudioPlayerState.PLAYING
                ? _pause()
                : _play();
            },
            icon: Icon(
              audioPlayer.state == AudioPlayerState.PLAYING
                ? Icons.pause
                : Icons.play_arrow, 
              color: AppStyle.accentColor, 
              size: 48
            ),
          ),
        ),
        if (_isInitialized) Flexible(
          flex: 4,
          child: Slider(
            value: _position.inSeconds.toDouble(), 
            onChanged: (value) => _seekTo(value),
            max: audioPlayer.duration.inSeconds.toDouble(),
            min: 0,
          ),
        )
      ],
    ),
  );

  void _initializePositionSubscription() {
    _positionSubscription = audioPlayer.onAudioPositionChanged
          .listen((p) => setState(() => _position = p));
  }

  void _play() {
    audioPlayer.play(_lullabies.values.toList()[_currentLullaby]);
  }

  void _pause() {
    audioPlayer.pause();
  }

  void _seekTo(double value) {
    audioPlayer.seek(value);
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _initializePositionSubscription();
    _currentLullaby = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TODO: it's not safe to align everything on the bottom, think of fab player controller
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Space(8.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Lullabies by Johnson's baby",
                  style: TextStyles.main,
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                children: _lullabies.keys.map((l) {
                  final index = _lullabies.keys.toList().indexOf(l);

                  return InkWell(
                    onTap: () {
                      _currentLullaby != index 
                        ? audioPlayer.play(_lullabies[l])
                        : audioPlayer.pause();
                      
                      setState(() => _currentLullaby = index);
                    },
                    child: CardLayout(
                      insidePadding: 16,
                      color: AppStyle.backgroundColor.withOpacity(0.7),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                              _currentLullaby != index 
                                ? Icons.play_arrow 
                                : Icons.pause,
                              color: AppStyle.accentColor,
                              size: 48,
                            
                          ),
                          Text(
                            l,
                            style: TextStyles.main,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: _playerController,
        )
      ],
    );
  }
}