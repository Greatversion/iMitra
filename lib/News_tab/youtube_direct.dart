import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GetInTouch extends StatefulWidget {
  const GetInTouch({Key? key}) : super(key: key);

  @override
  _GetInTouchState createState() => _GetInTouchState();
}

class _GetInTouchState extends State<GetInTouch> {
  late Future<void> _launchYoutubeVideo;

  @override
  void initState() {
    super.initState();
    _launchYoutubeVideo = launchYoutubeVideo('eNmb1y2FFLA');
  }

   launchYoutubeVideo(String videoId) async {
    final Uri url = Uri.parse('https://www.youtube.com/watch?v=$videoId');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _launchYoutubeVideo,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const SizedBox.shrink();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
