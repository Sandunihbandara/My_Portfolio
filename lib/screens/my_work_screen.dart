import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyWorkScreen extends StatefulWidget {
  const MyWorkScreen({super.key});

  @override
  State<MyWorkScreen> createState() => _MyWorkScreenState();
}

class _MyWorkScreenState extends State<MyWorkScreen>
    with TickerProviderStateMixin {
  late AnimationController _titleController;
  late Animation<double> _titleFade;
  late Animation<Offset> _titleSlide;

  late AnimationController _subtitleController;
  late Animation<double> _subtitleFade;
  late Animation<Offset> _subtitleSlide;

  final List<ProjectItem> projects = [
    ProjectItem(
      title: "AcademiCore University Instrument allocation system (Laravel,mysql,js,tailwindCSS)",
      imagePath: "assets/projects/AcademiCore.png",
      githubUrl: "https://github.com/Sandunihbandara/manual_auth.git",
    ),
    ProjectItem(
      title: "Giftos gift shop (Laravel,mysql,tailwindCSS)",
      imagePath: "assets/projects/Gitos.png",
      githubUrl: "https://github.com/Sandunihbandara/laraecommerce.git",
    ),
    ProjectItem(
      title: "JS DOM TextEditor(JavaScript,Html,Bootstrap)",
      imagePath: "assets/projects/JS_DOM.png",
      githubUrl: "https://github.com/Sandunihbandara/text-editor-application.git",
    ),
  ];

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
      begin: const Offset(0, -0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.easeOutBack),
    );

    _subtitleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );

    _subtitleFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _subtitleController, curve: Curves.easeIn),
    );

    _subtitleSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _subtitleController, curve: Curves.easeOutBack),
    );

    _titleController.forward();

    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) {
        _subtitleController.forward();
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
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
          "My Work",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        child: Column(
          children: [
            FadeTransition(
              opacity: _titleFade,
              child: SlideTransition(
                position: _titleSlide,
                child: const Text(
                  "  My Creative Works",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            FadeTransition(
              opacity: _subtitleFade,
              child: SlideTransition(
                position: _subtitleSlide,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: "Latest ",
                            style: TextStyle(color: Colors.black54),
                          ),
                          TextSpan(
                            text: "Projects",
                            style: TextStyle(color: Colors.purple),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    const MovingPinkIcon(),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 35),

            Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: projects
                  .map(
                    (project) => ProjectFlipCard(project: project),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectItem {
  final String title;
  final String imagePath;
  final String githubUrl;

  ProjectItem({
    required this.title,
    required this.imagePath,
    required this.githubUrl,
  });
}

class ProjectFlipCard extends StatefulWidget {
  final ProjectItem project;

  const ProjectFlipCard({
    super.key,
    required this.project,
  });

  @override
  State<ProjectFlipCard> createState() => _ProjectFlipCardState();
}

class _ProjectFlipCardState extends State<ProjectFlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isFront = true;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
      value: 0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    setState(() {
      _isFront = !_isFront;
    });
  }

  Future<void> _openGitHub() async {
    final Uri url = Uri.parse(widget.project.githubUrl);

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Could not open GitHub link")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovering = false;
        });
      },
      child: GestureDetector(
        onTap: _flipCard,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 520,
          height: 360,
          transform: Matrix4.identity()
            ..translate(0.0, _isHovering ? -8.0 : 0.0)
            ..scale(_isHovering ? 1.02 : 1.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final angle = _controller.value * math.pi;
              final isBack = angle > math.pi / 2;

              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0012)
                  ..rotateY(angle),
                child: isBack
                    ? Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(math.pi),
                  child: _buildBackCard(),
                )
                    : _buildFrontCard(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFrontCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              widget.project.imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              color: Colors.black.withOpacity(0.45),
              child: const Text(
                "Tap to flip",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blueGrey.shade200,
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.work_outline,
            size: 35,
            color: Colors.purple,
          ),
          const SizedBox(height: 5),
          Text(
            widget.project.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 18),
          ElevatedButton.icon(
            onPressed: _openGitHub,
            icon: const Icon(Icons.link),
            label: const Text("GitHub Link"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            "Tap card again to flip back",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
class MovingPinkIcon extends StatefulWidget {
  const MovingPinkIcon({super.key});

  @override
  State<MovingPinkIcon> createState() => _MovingPinkIconState();
}

class _MovingPinkIconState extends State<MovingPinkIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -4 * math.sin(_controller.value * math.pi)),
          child: Transform.rotate(
            angle: 0.15 * math.sin(_controller.value * math.pi * 2),
            child: child,
          ),
        );
      },
      child: const Icon(
        Icons.auto_awesome,
        color: Colors.purple,
        size: 28,
      ),
    );
  }
}