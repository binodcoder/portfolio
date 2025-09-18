import 'package:binodfolio/src/features/breathing/domain/breathing_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/patterns.dart';
import '../../domain/breath_pattern.dart';
import '../../domain/phase_info.dart';

class BreathingController extends StateNotifier<BreathingState> {
  BreathingController()
      : super(BreathingState(pattern: patterns.first, running: false));

  void toggle(AnimationController controller) {
    final nextRunning = !state.running;
    state = state.copyWith(running: nextRunning);
    if (nextRunning) {
      if (controller.status == AnimationStatus.completed) {
        controller.forward(from: 0);
      } else {
        controller.forward();
      }
    } else {
      controller.stop();
    }
  }

  void reset(AnimationController controller) {
    controller.stop();
    controller.value = 0;
    state = state.copyWith(running: false);
  }

  void changePattern(BreathPattern next, AnimationController controller) {
    final wasRunning = state.running;
    state = state.copyWith(pattern: next, running: false);
    controller.stop();
    controller.duration = Duration(seconds: next.total);
    if (wasRunning) {
      state = state.copyWith(running: true);
      controller.forward(from: 0);
    }
  }

  void onStatusChange(AnimationStatus status, AnimationController controller) {
    if (status == AnimationStatus.completed && state.running) {
      controller.forward(from: 0);
    }
  }

  PhaseInfo phaseInfo(double t) {
    final p = state.pattern;
    final total = p.total.toDouble();
    final seconds = t * total;

    final endIn = p.inhale.toDouble();
    final endH1 = endIn + p.hold1;
    final endEx = endH1 + p.exhale;

    if (seconds < endIn) {
      final local = p.inhale == 0 ? 1.0 : (seconds) / (p.inhale);
      final remain = (p.inhale - (seconds)).ceil().clamp(0, p.inhale).toInt();
      return PhaseInfo(BreathPhase.inhale, local.clamp(0.0, 1.0), remain);
    } else if (seconds < endH1) {
      final elapsed = seconds - endIn;
      final remain = (p.hold1 - elapsed).ceil().clamp(0, p.hold1).toInt();
      return PhaseInfo(BreathPhase.holdFull, 0, remain);
    } else if (seconds < endEx) {
      final elapsed = seconds - endH1;
      final local = p.exhale == 0 ? 1.0 : elapsed / p.exhale;
      final remain = (p.exhale - elapsed).ceil().clamp(0, p.exhale).toInt();
      return PhaseInfo(BreathPhase.exhale, local.clamp(0.0, 1.0), remain);
    } else {
      final elapsed = seconds - endEx;
      final remain = (p.hold2 - elapsed).ceil().clamp(0, p.hold2).toInt();
      return PhaseInfo(BreathPhase.holdEmpty, 0, remain);
    }
  }

  double scaleAt(double t) {
    final p = state.pattern;
    final total = p.total.toDouble();

    double seg(double start, double len) => (t - start) / len;

    final a = p.inhale / total;
    final b = p.hold1 / total;
    final c = p.exhale / total;

    if (a > 0 && t < a) {
      return Curves.easeInOut.transform(t / a);
    } else if (t < a + b) {
      return 1.0;
    } else if (c > 0 && t < a + b + c) {
      return 1 - Curves.easeInOut.transform(seg(a + b, c)).clamp(0.0, 1.0);
    } else {
      return 0.0;
    }
  }

  String phaseLabel(BreathPhase phase) {
    switch (phase) {
      case BreathPhase.inhale:
        return 'Inhale';
      case BreathPhase.holdFull:
        return 'Hold';
      case BreathPhase.exhale:
        return 'Exhale';
      case BreathPhase.holdEmpty:
        return 'Hold';
    }
  }
}

final breathingProvider =
    StateNotifierProvider<BreathingController, BreathingState>((ref) {
  return BreathingController();
});
