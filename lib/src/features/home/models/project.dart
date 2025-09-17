class Project {
  final String title;
  final String description;
  final List<String> tech;
  final String? github;
  final String? live;
  final String? playStore;

  const Project({
    required this.title,
    required this.description,
    required this.tech,
    this.github,
    this.live,
    this.playStore,
  });
}
