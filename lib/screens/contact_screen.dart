import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'video_meet_screen.dart';


class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {

  /// ADD VARIABLES HERE
  int hoveredIndex = -1;
  double mouseX = 0;
  double mouseY = 0;


  Future<void> openLink(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open $url')),
        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {

    final List<Map<String, String>> contacts = [

      {
        "title": "Call",
        "image": "assets/icons/call.png",
        "url": "tel:+94702193830"
      },

      {
        "title": "WhatsApp",
        "image": "assets/icons/whatsapp.png",
        "url": "https://wa.me/94702193830"
      },

      {
        "title": "Email",
        "image": "assets/icons/email.png",
        "url": "mailto:sandunihbandara252@gmail.com"
      },

      {
        "title": "LinkedIn",
        "image": "assets/icons/linkedin.png",
        "url": "https://linkedin.com/in/sanduni-bandara-1496772b6"
      },

      {
        "title": "GitHub",
        "image": "assets/icons/github.png",
        "url": "https://github.com/Sandunihbandara"
      },

      {
        "title": "Video Meet",
        "image": "assets/icons/vedioConf.png",
        "url": "https://meet.jit.si/sanduni_portfolio_meeting"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact", style: TextStyle(fontSize: 26)),
      ),

      body: Column(
        children: [

          const SizedBox(height: 30),

          const Text(
            "Contact me if you need :)",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.orange.shade800,
              borderRadius: BorderRadius.circular(35),
            ),
            child: const Text(
              "Let's Talk!",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 30),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: contacts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 25,
                mainAxisSpacing: 25,
              ),
              itemBuilder: (context, index) {

                final item = contacts[index];
                bool isHovered = hoveredIndex == index;

                return MouseRegion(

                  onEnter: (_) {
                    setState(() {
                      hoveredIndex = index;
                    });
                  },

                  onExit: (_) {
                    setState(() {
                      hoveredIndex = -1;
                    });
                  },

                  onHover: (event) {
                    setState(() {
                      mouseX = event.localPosition.dx;
                      mouseY = event.localPosition.dy;
                    });
                  },

                  child: GestureDetector(
                    onTap: () {
                      if (item["title"] == "Video Meet") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const VideoMeetScreen(),
                          ),
                        );
                      } else {
                        openLink(item["url"]!);
                      }
                    },

                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),

                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateX((mouseY - 75) / 1000)
                        ..rotateY(-(mouseX - 75) / 1000)
                        ..scale(isHovered ? 1.08 : 1.0),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),

                        /// GLASSMORPHISM EFFECT
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.95),
                            Colors.white.withOpacity(0.25),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),

                        border: Border.all(
                          color: Colors.white.withOpacity(0.4),
                        ),

                        /// NEON GLOW
                        boxShadow: [
                          BoxShadow(
                            color: isHovered
                                ? Colors.purpleAccent.withOpacity(0.9)
                                : Colors.black12,
                            blurRadius: isHovered ? 30 : 10,
                            spreadRadius: isHovered ? 5 : 2,
                          )
                        ],
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          /// FLOATING ICON
                          TweenAnimationBuilder(
                            tween: Tween(begin: -6.0, end: 6.0),
                            duration: const Duration(seconds: 2),
                            curve: Curves.easeInOut,
                            builder: (context, value, child) {

                              return Transform.translate(
                                offset: Offset(0, sin(value) * 5),
                                child: child,
                              );

                            },
                            child: Image.asset(
                              item["image"]!,
                              height: 60,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            item["title"]!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );

              },
            ),
          ),
        ],
      ),
    );
  }
}
