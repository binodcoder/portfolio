import 'package:flutter/material.dart';
import 'package:my_cv/features/home/widgets/about_section.dart';
import 'package:my_cv/features/home/widgets/apps_section.dart';
import 'package:my_cv/features/home/widgets/brand.dart';
import 'package:my_cv/features/home/widgets/contact_section.dart';
import 'package:my_cv/features/home/widgets/footer.dart';
import 'package:my_cv/features/home/widgets/hero_section.dart';
import 'package:my_cv/features/home/widgets/media/media_section.dart';
import 'package:my_cv/features/home/widgets/mobile_menu.dart';
import 'package:my_cv/features/home/widgets/nav_bar.dart';
import 'package:my_cv/features/home/widgets/projects_section.dart';
import 'package:my_cv/features/home/widgets/section.dart';
import 'package:my_cv/features/home/widgets/skills_section.dart';

class HomePage extends StatefulWidget {
  final Future<void> Function(ThemeMode) onThemeChanged;
  final ThemeMode themeMode;

  const HomePage({
    required this.onThemeChanged,
    required this.themeMode,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _homeKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _appsKey = GlobalKey();
  final _mediaKey = GlobalKey();
  final _contactKey = GlobalKey();

  Future<void> _scrollTo(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null) return;
    final position = box.localToGlobal(Offset.zero);
    final offset = _scrollController.offset +
        position.dy -
        80; // account for app bar height
    await _scrollController.animateTo(
      offset.clamp(0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1100;
    // final isTablet = width >= 700 && width < 1100;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                children: [
                  const Brand(),
                  const Spacer(),
                  if (isDesktop)
                    NavBar(
                      onTap: _onNavTap,
                      onThemeChanged: widget.onThemeChanged,
                      themeMode: widget.themeMode,
                    )
                  else
                    MobileMenu(
                      onTap: _onNavTap,
                      onThemeChanged: widget.onThemeChanged,
                      themeMode: widget.themeMode,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Section(key: _homeKey, child: HeroSection(isDesktop: isDesktop)),
              Section(key: _aboutKey, child: const AboutSection()),
              Section(key: _skillsKey, child: const SkillsSection()),
              Section(key: _projectsKey, child: const ProjectsSection()),
              Section(key: _appsKey, child: AppsSection()),
              Section(key: _mediaKey, child: const MediaSection()),
              Section(key: _contactKey, child: const ContactSection()),
              const SizedBox(height: 32),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }

  void _onNavTap(String id) {
    switch (id) {
      case 'home':
        _scrollTo(_homeKey);
        break;
      case 'about':
        _scrollTo(_aboutKey);
        break;
      case 'skills':
        _scrollTo(_skillsKey);
        break;
      case 'projects':
        _scrollTo(_projectsKey);
        break;
      case 'apps':
        _scrollTo(_appsKey);
        break;
      case 'media':
        _scrollTo(_mediaKey);
        break;
      case 'contact':
        _scrollTo(_contactKey);
        break;
    }
  }
}
