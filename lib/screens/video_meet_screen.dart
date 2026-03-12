import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoMeetScreen extends StatefulWidget {
  const VideoMeetScreen({super.key});

  @override
  State<VideoMeetScreen> createState() => _VideoMeetScreenState();
}

class _VideoMeetScreenState extends State<VideoMeetScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadRequest(
        Uri.parse(
          'https://meet.jit.si/sanduni_portfolio_meeting#config.prejoinPageEnabled=false',
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Video Meet"),
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}