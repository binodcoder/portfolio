enum BreathPhase { inhale, holdFull, exhale, holdEmpty }

class PhaseInfo {
  final BreathPhase phase;
  final double phaseT; // 0..1
  final int remaining; // seconds remaining in this phase (rounded)

  PhaseInfo(this.phase, this.phaseT, this.remaining);
}
