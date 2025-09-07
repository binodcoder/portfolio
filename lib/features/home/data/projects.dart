import '../models/project.dart';

const projects = <Project>[
  Project(
    title: 'MeroKaam — Job Portal',
    description: 'Flutter + Spring Boot job portal with JWT and AES-256...',
    tech: ['Flutter', 'Spring Boot', 'JWT', 'AES-256', 'MySQL'],
    github: 'https://github.com/binodcoder',
    live: 'https://example.com/merokaam',
    playStore:
        'https://play.google.com/store/apps/details?id=com.example.merokaam',
  ),
  Project(
    title: 'Fitness App',
    description: 'Pre-loaded routines, live training, and walks feature...',
    tech: ['Flutter', 'Firebase', 'Live Video'],
    github: 'https://github.com/binodcoder',
  ),
  Project(
    title: 'Blog App',
    description:
        'A modern blog platform with markdown editor, offline caching, and dark mode. Supports draft publishing and image uploads.',
    tech: ['Flutter', 'Riverpod', 'Firebase Auth', 'Cloud Firestore', 'Markdown'],
    github: 'https://github.com/binodcoder',
    live: 'https://example.com/blog-app',
  ),
  Project(
    title: 'Tablet POS for Restaurant',
    description:
        'Tablet-first POS with table layout, KOT printing, split bills, and offline-first sync. Built for fast counter operations.',
    tech: ['Flutter', 'SQLite', 'Bluetooth Printing', 'Riverpod', 'REST API'],
    github: 'https://github.com/binodcoder',
  ),
  Project(
    title: 'Dental Clinic App',
    description:
        'Patient management, appointment scheduling, treatment plans, and reminders. Includes charting UI and role-based access.',
    tech: ['Flutter', 'Firebase', 'Cloud Functions', 'FCM', 'Stripe'],
    github: 'https://github.com/binodcoder',
  ),
  Project(
    title: 'Accounts App for Hotel & Restaurant Owners',
    description:
        'Ledger, expense tracking, daily sales, GST/VAT reports, and exports to Excel/PDF. Multi-outlet support with role permissions.',
    tech: ['Flutter', 'Hive', 'Riverpod', 'CSV/PDF Export', 'Charts'],
    github: 'https://github.com/binodcoder',
  ),
];
