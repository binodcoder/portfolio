class BreathPattern {
  final String name;
  final int inhale;
  final int hold1;
  final int exhale;
  final int hold2;

  const BreathPattern(
      this.name, this.inhale, this.hold1, this.exhale, this.hold2);

  int get total => inhale + hold1 + exhale + hold2;
}
