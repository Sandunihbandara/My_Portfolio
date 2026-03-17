import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoMeetScreen extends StatelessWidget {
  const VideoMeetScreen({super.key});

  Future<void> _openMeeting(BuildContext context) async {
    final Uri meetingUrl = Uri.parse(
      'https://meet.jit.si/sanduni_portfolio_meeting',
    );

    if (!await launchUrl(
      meetingUrl,
      mode: LaunchMode.externalApplication,
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open video meeting'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Video Meet"),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => _openMeeting(context),
          icon: const Icon(Icons.video_call),
          label: const Text("Open Meeting"),
        ),
      ),
    );
  }
}