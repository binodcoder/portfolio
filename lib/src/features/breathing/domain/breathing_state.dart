import 'package:binodfolio/src/features/breathing/domain/breath_pattern.dart';

class BreathingState {
  final BreathPattern pattern;
  final bool running;

  const BreathingState({required this.pattern, required this.running});

  BreathingState copyWith({BreathPattern? pattern, bool? running}) =>
      BreathingState(
        pattern: pattern ?? this.pattern,
        running: running ?? this.running,
      );
}
