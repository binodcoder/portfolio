import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_cv/common_widgets/bottom_nav_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  const _Brand(),
                  const Spacer(),
                  if (isDesktop)
                    _NavBar(
                      onTap: _onNavTap,
                      onThemeChanged: widget.onThemeChanged,
                      themeMode: widget.themeMode,
                    )
                  else
                    _MobileMenu(
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
              _Section(
                  key: _homeKey, child: _HeroSection(isDesktop: isDesktop)),
              _Section(key: _aboutKey, child: const _AboutSection()),
              _Section(key: _skillsKey, child: const _SkillsSection()),
              _Section(key: _projectsKey, child: const _ProjectsSection()),
              _Section(key: _contactKey, child: const _ContactSection()),
              const SizedBox(height: 32),
              const _Footer(),
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
      case 'contact':
        _scrollTo(_contactKey);
        break;
    }
  }
}

class _Brand extends StatelessWidget {
  const _Brand();
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .titleLarge
        ?.copyWith(fontWeight: FontWeight.w700);
    return Text('Binod.dev', style: style);
  }
}

class _NavBar extends StatelessWidget {
  final void Function(String id) onTap;
  final Future<void> Function(ThemeMode) onThemeChanged;
  final ThemeMode themeMode;

  const _NavBar({
    required this.onTap,
    required this.onThemeChanged,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _NavButton(label: 'Home', onTap: () => onTap('home')),
        _NavButton(label: 'About', onTap: () => onTap('about')),
        _NavButton(label: 'Skills', onTap: () => onTap('skills')),
        _NavButton(label: 'Projects', onTap: () => onTap('projects')),
        _NavButton(label: 'Contact', onTap: () => onTap('contact')),
        const SizedBox(width: 16),
        _ThemeToggle(
          onChanged: onThemeChanged,
          themeMode: themeMode,
        ),
        const SizedBox(width: 8),
        FilledButton.tonal(
          onPressed: () => _launch(
              'mailto:binodbhandari@gmail.com?subject=Let\'s work together'),
          child: const Text('Hire Me'),
        ),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _NavButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(label, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final ThemeMode themeMode;
  final Future<void> Function(ThemeMode) onThemeChanged;
  final void Function(String id) onTap;

  const _MobileMenu({
    required this.onTap,
    required this.onThemeChanged,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Menu',
      onSelected: (id) => id == 'theme' ? null : onTap(id),
      itemBuilder: (ctx) => [
        const PopupMenuItem(value: 'home', child: Text('Home')),
        const PopupMenuItem(value: 'about', child: Text('About')),
        const PopupMenuItem(value: 'skills', child: Text('Skills')),
        const PopupMenuItem(value: 'projects', child: Text('Projects')),
        const PopupMenuItem(value: 'contact', child: Text('Contact')),
        PopupMenuItem(
          enabled: false,
          value: 'theme',
          child: Row(
            children: [
              const Text('Theme'),
              const Spacer(),
              _ThemeToggle(themeMode: themeMode, onChanged: onThemeChanged),
            ],
          ),
        ),
      ],
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  final ThemeMode themeMode;
  final Future<void> Function(ThemeMode) onChanged;
  const _ThemeToggle({required this.themeMode, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ThemeMode>(
      segments: const [
        ButtonSegment(value: ThemeMode.light, label: Text('☀️')),
        ButtonSegment(value: ThemeMode.dark, label: Text('🌙')),
      ],
      selected: {themeMode == ThemeMode.system ? ThemeMode.light : themeMode},
      onSelectionChanged: (s) => onChanged(s.first),
      showSelectedIcon: false,
    );
  }
}

class _Section extends StatelessWidget {
  final Widget child;
  const _Section({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 56),
      constraints: const BoxConstraints(maxWidth: 1400),
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: child,
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final bool isDesktop;
  const _HeroSection({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final column = constraints.maxWidth < 900;
        return Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 24,
          spacing: 24,
          children: [
            SizedBox(
              width: column
                  ? constraints.maxWidth
                  : min(520, constraints.maxWidth * 0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hi, I\'m Binod 👋',
                      style: textTheme.displaySmall
                          ?.copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 12),
                  Text(
                      'Flutter Developer • Spring Boot • AWS (free tier wizard) • MSc CS with Distinction',
                      style: textTheme.titleMedium),
                  const SizedBox(height: 20),
                  Row(children: [
                    FilledButton(
                        onPressed: () =>
                            _launch('https://github.com/binodcoder'),
                        child: const Text('GitHub')),
                    const SizedBox(width: 12),
                    OutlinedButton(
                        onPressed: () => _launch('https://www.linkedin.com'),
                        child: const Text('LinkedIn')),
                    const SizedBox(width: 12),
                    TextButton(
                        onPressed: () =>
                            _launch('assets/Binod_Bhandari_CV.pdf'),
                        child: const Text('Download CV')),
                    TextButton(
                        onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomNavScaffold(),
                              ),
                            ),
                        child: const Text('More')),
                  ]),
                ],
              ),
            ),
            _Avatar(),
          ],
        );
      },
    );
  }
}

class _Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = min(MediaQuery.of(context).size.width * 0.35, 260.0);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(.25),
            Theme.of(context).colorScheme.secondary.withOpacity(.25),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      alignment: Alignment.center,
      child: CircleAvatar(
        radius: size / 2 - 8,
        backgroundImage: const AssetImage(
            'assets/images/photo.jpg'), // put your photo at assets/avatar.png
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection();
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About Me',
            style: t.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        Text(
          "I'm a Flutter developer based in the UK, with experience in Spring Boot backends, JWT auth, and deploying on AWS free tier. I built MeroKaam (job portal) and a fitness app with live sessions and walking routes.",
          style: t.titleMedium,
        ),
      ],
    );
  }
}

class _SkillsSection extends StatelessWidget {
  const _SkillsSection();
  @override
  Widget build(BuildContext context) {
    final chips = [
      'Flutter',
      'Dart',
      'BLoC',
      'Riverpod',
      'Spring Boot',
      'REST API',
      'JWT',
      'AES-256',
      'Firebase',
      'Firestore',
      'CI/CD',
      'GitHub Actions',
      'AWS',
      'RDS',
      'VPC',
      'MySQL',
      'PostgreSQL',
      'Unit/Widget Tests'
    ];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: chips.map((c) => Chip(label: Text(c))).toList(),
    );
  }
}

class Project {
  final String title;
  final String description;
  final List<String> tech;
  final String? github;
  final String? live;
  final String? playStore;
  Project(
      {required this.title,
      required this.description,
      required this.tech,
      this.github,
      this.live,
      this.playStore});
}

final projects = <Project>[
  Project(
    title: 'MeroKaam — Job Portal',
    description:
        'Flutter + Spring Boot job portal with JWT and AES-256. Published on Play Store + Web app.',
    tech: ['Flutter', 'Spring Boot', 'JWT', 'AES-256', 'MySQL'],
    github: 'https://github.com/binodcoder',
    live: 'https://example.com/merokaam',
    playStore:
        'https://play.google.com/store/apps/details?id=com.example.merokaam',
  ),
  Project(
    title: 'Fitness App',
    description:
        'Pre-loaded routines, live training, and walks feature with domain-limited sharing.',
    tech: ['Flutter', 'Firebase', 'Live Video'],
    github: 'https://github.com/binodcoder',
  ),
  Project(
    title: 'Driving Theory UK (WIP)',
    description:
        'Flutter + Spring Boot app for UK learners. Focus on database design and tests.',
    tech: ['Flutter', 'Spring Boot', 'PostgreSQL'],
  ),
];

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection();
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Projects',
            style: t.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, c) {
            final isWide = c.maxWidth > 1000;
            final gridCount = isWide ? 3 : (c.maxWidth > 700 ? 2 : 1);
            return GridView.builder(
              itemCount: projects.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: isWide ? 1.25 : 1.05,
              ),
              itemBuilder: (context, i) => _ProjectCard(p: projects[i]),
            );
          },
        )
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project p;
  const _ProjectCard({required this.p});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: cs.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(p.title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Expanded(child: Text(p.description)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: p.tech.map((t) => Chip(label: Text(t))).toList(),
            ),
            const SizedBox(height: 12),
            Wrap(spacing: 8, children: [
              if (p.github != null)
                OutlinedButton(
                    onPressed: () => _launch(p.github!),
                    child: const Text('GitHub')),
              if (p.live != null)
                FilledButton.tonal(
                    onPressed: () => _launch(p.live!),
                    child: const Text('Live Demo')),
              if (p.playStore != null)
                FilledButton(
                    onPressed: () => _launch(p.playStore!),
                    child: const Text('Play Store')),
            ])
          ],
        ),
      ),
    );
  }
}

class _ContactSection extends StatelessWidget {
  const _ContactSection();
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contact',
            style: t.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        Wrap(spacing: 12, runSpacing: 12, children: [
          FilledButton.icon(
              onPressed: () => _launch('mailto:binodbhandari@example.com'),
              icon: const Icon(Icons.email),
              label: const Text('Email')),
          OutlinedButton.icon(
              onPressed: () => _launch('https://github.com/binodcoder'),
              icon: const Icon(Icons.code),
              label: const Text('GitHub')),
          OutlinedButton.icon(
              onPressed: () => _launch('https://www.linkedin.com'),
              icon: const Icon(Icons.person),
              label: const Text('LinkedIn')),
          TextButton(
              onPressed: () => _launch('https://twitter.com'),
              child: const Text('X / Twitter')),
        ]),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();
  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          const Divider(height: 1),
          const SizedBox(height: 16),
          Text('© $year Binod Bhandari • Built with Flutter'),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

Future<void> _launch(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, webOnlyWindowName: '_blank')) {
    debugPrint('Could not launch $url');
  }
}
