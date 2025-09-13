import 'package:binodfolio/features/home/widgets/about_section.dart';
import 'package:binodfolio/features/home/widgets/apps_section.dart';
import 'package:binodfolio/features/home/widgets/brand.dart';
import 'package:binodfolio/features/home/widgets/contact_section.dart';
import 'package:binodfolio/features/home/widgets/footer.dart';
import 'package:binodfolio/features/home/widgets/hero_section.dart';
import 'package:binodfolio/features/home/widgets/media/media_section.dart';
import 'package:binodfolio/features/home/widgets/mobile_menu.dart';
import 'package:binodfolio/features/home/widgets/nav_bar.dart';
import 'package:binodfolio/features/home/widgets/projects_section.dart';
import 'package:binodfolio/features/home/widgets/section.dart';
import 'package:binodfolio/features/home/widgets/skills_section.dart';
import 'package:flutter/material.dart';
import 'package:binodfolio/core/responsive/breakpoints.dart';
import 'package:binodfolio/core/responsive/sizes.dart';

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
  final _contactKey = GlobalKey();
  final _mediaKey = GlobalKey();

  Future<void> _scrollTo(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      alignment: 0.05, // leave some space under navbar
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isNavDesktop;
    // final isTablet = width >= 700 && width < 1100;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Inline header (replaces Scaffold.appBar)
            Container(
              color: Theme.of(context).colorScheme.surface,
              padding: context.insetsSymmetric(h: 16, v: 8),
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
            // Scrollable content
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Section(
                          key: _homeKey,
                          child: HeroSection(isDesktop: isDesktop)),
                      Section(key: _aboutKey, child: const AboutSection()),
                      Section(key: _skillsKey, child: const SkillsSection()),
                      Section(
                          key: _projectsKey, child: const ProjectsSection()),
                      Section(key: _appsKey, child: AppsSection()),
                      Section(key: _contactKey, child: const ContactSection()),
                      Section(key: _mediaKey, child: const MediaSection()),
                      const SizedBox(height: 8),
                      const Footer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
      case 'contact':
        _scrollTo(_contactKey);
        break;
      case 'media':
        _scrollTo(_mediaKey);
        break;
    }
  }
}
