import 'package:flutter/material.dart';
import 'dart:math' as math;

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with TickerProviderStateMixin {
  late AnimationController _titleController;
  late Animation<double> _titleFade;
  late Animation<Offset> _titleSlide;
  late AnimationController _barController;
  late AnimationController _helloIconController;

  @override
  void initState() {
    super.initState();

    _titleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _titleFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.easeIn),
    );

    _titleSlide = Tween<Offset>(
      begin: const Offset(0, -0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.easeOutBack),
    );

    _barController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _helloIconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _titleController.forward();

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _barController.forward();
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _barController.dispose();
    _helloIconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F1F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "About Me",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeTransition(
              opacity: _titleFade,
              child: SlideTransition(
                position: _titleSlide,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Hello!",
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 10),
                    AnimatedBuilder(
                      animation: _helloIconController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(
                            0,
                            -5 * (0.5 - (_helloIconController.value - 0.5).abs()) * 2,
                          ),
                          child: Transform.rotate(
                            angle: 0.28 * math.sin(_helloIconController.value * 2 * math.pi),
                            child: child,
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.waving_hand_rounded,
                        color: Colors.orange,
                        size: 34,
                      ),
                    ),
                  ],
                ),
              ),
            ),


            const SizedBox(height: 8),

            FadeTransition(
              opacity: _titleFade,
              child: SlideTransition(
                position: _titleSlide,
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: "I am ",
                        style: TextStyle(color: Colors.black87),
                      ),
                      TextSpan(
                        text: "Sanduni",
                        style: TextStyle(color: Colors.purple),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            _buildSectionTitle("Education Qualifications"),

            const SizedBox(height: 14),

            _buildEducationCard(
              title: "Bachelor Degree",
              details: [
                "BICT(Hons) in Software",
                "University of Colombo",
                "Second year",
              ],
              icon: Icons.workspace_premium_outlined,
              color: Colors.green.shade100,
            ),

            const SizedBox(height: 16),

            _buildEducationCard(
              title: "A/L Results",
              details: [
                "Technology",
                "Balalla Central college",
                "ICT-A  ET-B  SFT-B",
              ],
              icon: Icons.menu_book_outlined,
              color: Colors.blue.shade100,
            ),

            const SizedBox(height: 16),

            _buildEducationCard(
              title: "O/L Results",
              details: [
                "Anuradhapura Central College",
                "English Medium",
                "English- A  Sinhala- A   ICT- A  "
                    "Maths-A   History-A   Buddhism-A   "
                    "Commerce-A (7A)",
                "Science -B   English Lit -B (2B)"
              ],
              icon: Icons.school_outlined,
              color: Colors.pink.shade100,
            ),



            const SizedBox(height: 34),

            _buildSectionTitle("Skills"),

            const SizedBox(height: 18),

            _buildSkillGroupCard(
              title: "Technical Skills",
              color: Colors.purple.shade100,
              children: [
                AnimatedSkillBar(
                  controller: _barController,
                  skill: "UI Design",
                  percentage: 0.80,
                  barColor: Colors.purple,
                ),
                AnimatedSkillBar(
                  controller: _barController,
                  skill: "Database Handling",
                  percentage: 0.75,
                  barColor: Colors.deepPurple,
                ),
                AnimatedSkillBar(
                  controller: _barController,
                  skill: "Project Documentation",
                  percentage: 0.85,
                  barColor: Colors.pink,
                ),
              ],
            ),

            const SizedBox(height: 18),

            _buildSkillGroupCard(
              title: "Software Skills",
              color: Colors.blue.shade100,
              children: [
                AnimatedSkillBar(
                  controller: _barController,
                  skill: "Figma",
                  percentage: 0.78,
                  barColor: Colors.blue,
                ),
                AnimatedSkillBar(
                  controller: _barController,
                  skill: "VS Code",
                  percentage: 0.88,
                  barColor: Colors.indigo,
                ),
                AnimatedSkillBar(
                  controller: _barController,
                  skill: "Android Studio",
                  percentage: 0.73,
                  barColor: Colors.cyan,
                ),
              ],
            ),

            const SizedBox(height: 18),

            _buildSkillGroupCard(
              title: "Coding Skills",
              color: Colors.green.shade100,
              children: [
                AnimatedSkillBar(
                  controller: _barController,
                  skill: "HTML / CSS",
                  percentage: 0.90,
                  barColor: Colors.green,
                ),
                AnimatedSkillBar(
                  controller: _barController,
                  skill: "Tailwind CSS",
                  percentage: 0.60,
                  barColor: Colors.green.shade800,
                ),
                AnimatedSkillBar(
                  controller: _barController,
                  skill: "JavaScript",
                  percentage: 0.78,
                  barColor: Colors.teal,
                ),
                AnimatedSkillBar(
                  controller: _barController,
                  skill: "Laravel / PHP",
                  percentage: 0.82,
                  barColor: Colors.lightGreen,
                ),
                AnimatedSkillBar(
                  controller: _barController,
                  skill: "Flutter",
                  percentage: 0.70,
                  barColor: Colors.greenAccent.shade700,
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildEducationCard({
    required String title,
    required List<String> details,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: color, width: 1.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color,
            child: Icon(
              icon,
              color: Colors.black87,
              size: 26,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                ...details.map(
                      (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "• ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillGroupCard({
    required String title,
    required Color color,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: color, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 18),
          ...children,
        ],
      ),
    );
  }
}

class AnimatedSkillBar extends StatelessWidget {
  final AnimationController controller;
  final String skill;
  final double percentage;
  final Color barColor;

  const AnimatedSkillBar({
    super.key,
    required this.controller,
    required this.skill,
    required this.percentage,
    required this.barColor,
  });

  @override
  Widget build(BuildContext context) {
    final animation = Tween<double>(
      begin: 0,
      end: percentage,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutCubic,
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      skill,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Text(
                    "${(animation.value * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: barColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 16,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: animation.value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: barColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}