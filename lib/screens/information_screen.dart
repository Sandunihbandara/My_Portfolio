import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;

  late AnimationController _iconController;

  @override
  void initState() {
    super.initState();

    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _headerFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeIn),
    );

    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOutBack),
    );

    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _headerController.forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  Future<void> _openLink(String value) async {
    String link = value.trim();

    if (link.startsWith("GitHub:")) {
      link = link.replaceFirst("GitHub:", "").trim();
    } else if (link.startsWith("LinkedIn:")) {
      link = link.replaceFirst("LinkedIn:", "").trim();
    } else if (link.startsWith("Email:")) {
      final email = link.replaceFirst("Email:", "").trim();
      link = "mailto:$email";
    }

    final uri = Uri.parse(link);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could not open link")),
        );
      }
    }
  }

  Widget _buildTopIconBox(IconData icon, String label) {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _iconController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, -4 * _iconController.value),
                child: child,
              );
            },
            child: Icon(
              icon,
              color: Colors.white,
              size: 50,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required List<String> items,
    Color iconColor = Colors.purple,
    bool clickable = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E3152),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ...items.map(
                (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InkWell(
                onTap: clickable ? () => _openLink(item) : null,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clickable ? "↗ " : "• ",
                      style: TextStyle(
                        color: clickable ? Colors.blue : Colors.purple,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 17,
                          height: 1.5,
                          color: clickable
                              ? Colors.blue.shade700
                              : const Color(0xFF3D4060),
                          decoration: clickable
                              ? TextDecoration.underline
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Divider(
        color: Colors.grey.shade300,
        thickness: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEADCF8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEADCF8),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Info",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        child: FadeTransition(
          opacity: _headerFade,
          child: SlideTransition(
            position: _headerSlide,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF59C7DB),
                        Color(0xFF62CFE0),
                        Color(0xFF7BDDE8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.circular(42),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.75),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 28),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Who am I?",
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          "I am Sanduni Bandara, a passionate undergraduate in Software Engineering who enjoys building user-friendly web and mobile applications. I love combining creativity with technology through UI design, coding, and modern development tools.",
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.6,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(height: 26),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildTopIconBox(Icons.badge_outlined, "Personal"),
                            _buildTopIconBox(Icons.favorite_outline, "Interests"),
                            _buildTopIconBox(Icons.link_outlined, "Links"),
                          ],
                        ),
                      ),

                      const SizedBox(height: 18),

                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF8F7FC),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(42),
                            topRight: Radius.circular(42),
                            bottomLeft: Radius.circular(42),
                            bottomRight: Radius.circular(42),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 18),

                            _buildSection(
                              icon: Icons.person_outline,
                              title: "Personal Information",
                              items: const [
                                "Name: Sanduni Bandara",
                                "University: University of Colombo",
                                "Degree: BICT (Hons) in Software",
                                "Academic Level: Second Year",
                                "Location: Sri Lanka",
                              ],
                              iconColor: Colors.purple,
                            ),

                            _buildDivider(),

                            _buildSection(
                              icon: Icons.auto_awesome_outlined,
                              title: "Interests",
                              items: const [
                                "Web Application Development",
                                "Mobile Application Development",
                                "UI / UX Design",
                                "Software System Design",
                                "Problem Solving",
                                "Learning New Technologies",
                                "Creative Software Development",
                                "Digital Product Design",
                                "Human-Centered Design",
                              ],
                              iconColor: Colors.pink,
                            ),

                            _buildDivider(),

                            _buildSection(
                              icon: Icons.public,
                              title: "Social Links",
                              items: const [
                                "GitHub: https://github.com/Sandunihbandara",
                                "LinkedIn: https://www.linkedin.com/",
                                "Email: yourmail@example.com",
                              ],
                              iconColor: Colors.blue,
                              clickable: true,
                            ),

                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}