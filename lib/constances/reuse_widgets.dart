import 'package:flutter/material.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';


class YoutubeViewer extends StatefulWidget {
  final String? videoID;
  YoutubeViewer(this.videoID);
  @override
  _YoutubeViewerState createState() => _YoutubeViewerState();
}

class _YoutubeViewerState extends State<YoutubeViewer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: '${widget.videoID}', // livestream example
      params: YoutubePlayerParams(
        //startAt: Duration(minutes: 1, seconds: 5),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: false,
        autoPlay: true,
        enableCaption: true,
        showVideoAnnotations: false,
        enableJavaScript: true,
        privacyEnhanced: true,
        useHybridComposition: true,
        playsInline: false,
      ),
    )..listen((value) {
      print(_controller.value.position);
      if (value.isReady && !value.hasPlayed) {
        _controller
          ..hidePauseOverlay()
          ..play()
          ..hideTopMenu();
      }
      if (value.hasPlayed) {
        _controller..hideEndScreen();
      }
    });

    _controller.onExitFullscreen = () {
      Navigator.of(context).pop();
    };
  }

  @override
  Widget build(BuildContext context) {
    final player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      key: UniqueKey(),
      controller: _controller,
      child: AlertDialog(
          insetPadding: EdgeInsets.all(10),
          backgroundColor: Colors.white,
          content: Container(height: 450, width: double.infinity-50, child: player),
          contentPadding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          )
      ),
    );
  }
}


navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
