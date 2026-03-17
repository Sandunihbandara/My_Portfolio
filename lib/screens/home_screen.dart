import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'about_me_screen.dart';
import 'my_work_screen.dart';
import 'information_screen.dart';
import 'contact_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _introController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _nameSlideAnimation;
  late Animation<Offset> _jobSlideAnimation;

  late AnimationController _nameGlowController;
  late Animation<Color?> _nameColorAnimation;

  late AnimationController _developerIconController;

  late AnimationController _phoneController;

  bool _isNameHover = false;
  bool _isJobHover = false;

  @override
  void initState() {
    super.initState();

    /// Opening animation
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _introController,
        curve: Curves.easeIn,
      ),
    );

    _nameSlideAnimation = Tween<Offset>(
      begin: const Offset(-0.5, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: Curves.easeOutBack,
      ),
    );

    _jobSlideAnimation = Tween<Offset>(
      begin: const Offset(0.5, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: Curves.easeOutBack,
      ),
    );

    /// Name color animation
    _nameGlowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16000000),
    )..repeat(reverse: true);

    _nameColorAnimation = ColorTween(
      begin: Colors.black,
      end: Colors.black,
    ).animate(
      CurvedAnimation(
        parent: _nameGlowController,
        curve: Curves.easeInOut,
      ),
    );

    /// Developer icon animation
    _developerIconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);



    _introController.forward();

    /// Phone icon animation
    _phoneController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _introController.dispose();
    _phoneController.dispose();
    _nameGlowController.dispose();
    _developerIconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xEFEFEAFF),
      body: Center(
        child: Column(
          children: [
            /// PROFILE CARD
            Container(
              width: 920,
              height: 500,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 70),

                  /// NAME
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _nameSlideAnimation,
                      child: MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _isNameHover = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _isNameHover = false;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 350),
                          transform: Matrix4.translationValues(
                            _isNameHover ? 18 : 0,
                            _isNameHover ? -6 : 0,
                            0,
                          )..scale(_isNameHover ? 1.04 : 1.0),
                          child: AnimatedBuilder(
                            animation: _nameColorAnimation,
                            builder: (context, child) {
                              return Text(
                                "  Sanduni Bandara",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.bold,
                                  color: _nameColorAnimation.value,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.8),
                                      blurRadius: 4,
                                    ),
                                  ],

                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// SOFTWARE DEVELOPER
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _jobSlideAnimation,
                      child: MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _isJobHover = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _isJobHover = false;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          transform: Matrix4.translationValues(
                            _isJobHover ? 14 : 0,
                            _isJobHover ? -4 : 0,
                            0,
                          )..scale(_isJobHover ? 1.03 : 1.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 12),

                              AnimatedBuilder(
                                animation: _developerIconController,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(
                                      0,
                                      -4 * math.sin(_developerIconController.value * math.pi),
                                    ),
                                    child: Transform.rotate(
                                      angle: 0.12 *
                                          math.sin(_developerIconController.value * math.pi * 2),
                                      child: child,
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.laptop_mac,
                                  color: Colors.purple,
                                  size: 23,
                                ),
                              ),

                              const SizedBox(width: 10),

                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Software ",
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                    TextSpan(
                                      text: "Developer",
                                      style: TextStyle(color: Colors.purple),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// IMAGE
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Transform.scale(
                        scale: 1.4,
                        child: Image.asset(
                          "assets/avatar.png",
                          width: double.infinity,
                          alignment: Alignment.topCenter,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// HELP BOX
            Container(
              width: 620,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 9),
                  const Text(
                    "Can I help you?",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Let's work!",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),

                  /// CONTACT BUTTON
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ContactScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade700,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBuilder(
                          animation: _phoneController,
                          builder: (context, child) {
                            double angle =
                                math.sin(_phoneController.value * math.pi * 4) *
                                    0.18;

                            return Transform.rotate(
                              angle: angle,
                              child: Transform.translate(
                                offset: Offset(
                                  math.sin(_phoneController.value * math.pi * 2) * 2,
                                  0,
                                ),
                                child: child,
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.phone_in_talk,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Contact Me",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            /// MENU BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildMenuButton("My Work", Icons.work_outline, Colors.pinkAccent.shade100, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyWorkScreen(),
                    ),
                  );
                }),
                const SizedBox(width: 25),
                buildMenuButton("About Me", Icons.person_outline,
                    Colors.blue.shade300,
                        () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutScreen(),
                    ),
                  );
                }),
                const SizedBox(width: 25),
                buildMenuButton("Info", Icons.info_outline,
                    Colors.green.shade300,
                        () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InformationScreen(),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuButton(String text, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 105,
        height: 80,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        const SizedBox(height: 6),

        Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
        ],
        ),
      ),
    );
  }
}