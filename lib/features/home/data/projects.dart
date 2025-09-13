import '../models/project.dart';

const projects = <Project>[
  Project(
    title: 'MeroKaam — Job Portal',
    description:
        'a full-stack job portal web and mobile app with secure JWT authentication, AES-256 encryption, and role-based access. Implemented a responsive UI, job posting and application management features, following SOLID principles and Clean Architecture using Flutter (BLoC), Spring Boot, Thymeleaf, and MySQL.',
    tech: ['Flutter', 'Spring Boot', 'MySQL'],
    github: 'https://github.com/binodcoder',
    // live: 'https://example.com/merokaam',
    // playStore:
    //     'https://play.google.com/store/apps/details?id=com.example.merokaam',
  ),
  Project(
    title: 'Fitness App',
    description:
        'A fitness app with pre-loaded routines, real-time training sessions, and a domain-restricted “Walks” feature for community engagement. Integrated calendar sync for booking trainer sessions, following SOLID principles and Clean Architecture.',
    tech: ['Flutter', 'Firebase', 'Live Video'],
    github: 'https://github.com/binodcoder',
  ),
  Project(
    title: 'Portfolio App',
    description:
        'A responsive Flutter web and mobile app with Material 3 design and dark mode support. Included mini apps such as Expenses, Shopping, Pomodoro, Breathing, and Meals, using Riverpod for state management, REST/HTTP APIs, and SharedPreferences. Built with a modular architecture, reusable widgets, and smooth animations for a seamless user experience.',
    tech: [
      'Flutter',
      'Riverpod',
      'Firebase',
    ],
    github: 'https://github.com/binodcoder',
  ),
];
