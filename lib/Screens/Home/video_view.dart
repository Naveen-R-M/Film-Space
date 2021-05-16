import 'dart:io';

import 'package:film_space/my_colors.dart';
import 'package:film_space/user_files.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class VideoView extends StatefulWidget {
  final index;
  VideoView({this.index});
  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  VideoPlayerController _videoPlayerController;
  bool isLandScape = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController = VideoPlayerController.file(
      File(UserFiles.selectedVideo[widget.index]),
    )
      ..addListener(
        () {
          if (mounted) {
            setState(() {});
          }
        },
      )
      ..setLooping(true)
      ..initialize().then((value) => _videoPlayerController.play());
  }

  Future setLandscape() async {
    if (isLandScape == false) {
      await SystemChrome.setEnabledSystemUIOverlays([]);
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
      await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    }
  }

  String getPosition() {
    final duration = Duration(
        milliseconds:
            _videoPlayerController.value.position.inMilliseconds.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((e) => e.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final isMuted = _videoPlayerController.value.volume == 0;

    var videoWidth = _videoPlayerController.value.size.width;
    var videoHeight = _videoPlayerController.value.size.height;

    var aspectRatio = _videoPlayerController.value.size.aspectRatio;

    print(
      'video Height : ${_videoPlayerController.value.size.aspectRatio}, '
      '$videoHeight, '
      '$videoWidth,'
      '$height,'
      '$width,',
    );

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () => _videoPlayerController.pause(),
                  child: Container(
                    height: isLandScape ? height : null,
                    width: isLandScape ? width : null,
                    child: AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          VideoPlayer(
                            _videoPlayerController,
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: width,
                            child: _videoPlayerController.value.isPlaying
                                ? Container()
                                : IconButton(
                                    onPressed: () =>
                                        _videoPlayerController.play(),
                                    icon: Icon(
                                      Icons.play_arrow,
                                      size: 50,
                                      color: Colors.white70,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 25,
                  left: 10,
                  child: Text(getPosition()),
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      setLandscape();
                      setState(() {
                        isLandScape = !isLandScape;
                      });
                    },
                    icon: Icon(
                      isLandScape == false
                          ? Icons.fullscreen
                          : Icons.fullscreen_exit,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  left: 0,
                  child: VideoProgressIndicator(
                    _videoPlayerController,
                    allowScrubbing: true,
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                  ),
                ),
              ],
            ),
            if (isLandScape == false)
              Column(
                children: [
                  Container(
                    child: Center(
                      child: IconButton(
                        color: Colors.white,
                        icon: Icon(
                          isMuted ? Icons.volume_off : Icons.volume_up,
                        ),
                        onPressed: () {
                          _videoPlayerController.setVolume(isMuted ? 1 : 0);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 8.0,
                      bottom: 16.0,
                    ),
                    child: Text(
                      UserFiles.title[widget.index],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ubuntu(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: Divider(
                      height: 1.5,
                    ),
                  ),
                  Container(
                    width: width,
                    padding: EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 8.0,
                      bottom: 8.0,
                    ),
                    child: Text(
                      '${UserFiles.description[widget.index]}',
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.ubuntu(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.white70,
                        height: 1.5,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerController.dispose();
    super.dispose();
  }
}
