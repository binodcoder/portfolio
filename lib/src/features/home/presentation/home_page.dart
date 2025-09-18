import 'package:binodfolio/src/features/home/presentation/widgets/about/about_section.dart';
import 'package:binodfolio/src/features/home/presentation/widgets/app_section/apps_section.dart';
import 'package:binodfolio/src/features/home/presentation/widgets/brand.dart';
import 'package:binodfolio/src/features/home/presentation/widgets/contact/contact_section.dart';
import 'package:binodfolio/src/features/home/presentation/widgets/footer.dart';
import 'package:binodfolio/src/features/home/presentation/widgets/hero/hero_section.dart';
import 'package:binodfolio/src/features/home/presentation/widgets/media/media_section.dart';
import 'package:binodfolio/src/features/home/presentation/widgets/mobile_menu/mobile_menu.dart';
import 'package:binodfolio/src/features/home/presentation/widgets/nav_bar/nav_bar.dart';
import 'package:binodfolio/src/features/home/presentation/widgets/project/projects_section.dart';
import 'package:binodfolio/src/features/home/presentation/widgets/section.dart';
import 'package:binodfolio/src/features/home/presentation/widgets/skill/skills_section.dart';
import 'package:flutter/material.dart';
import 'package:binodfolio/src/core/responsive/breakpoints.dart';
import 'package:binodfolio/src/core/responsive/sizes.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
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
                    )
                  else
                    MobileMenu(
                      onTap: _onNavTap,
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
