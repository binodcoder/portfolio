import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TimerPhase { focus, shortBreak, longBreak }

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  static const _kFocusKey = 'pomodoro_focus_minutes';
  static const _kShortKey = 'pomodoro_short_minutes';
  static const _kLongKey = 'pomodoro_long_minutes';
  static const _kLongEveryKey = 'pomodoro_long_every';

  Timer? _timer;
  TimerPhase _phase = TimerPhase.focus;
  int _focusMinutes = 25;
  int _shortMinutes = 5;
  int _longMinutes = 15;
  int _longEvery = 4; // after N focus sessions

  int _remainingSeconds = 25 * 60;
  int _completedFocus = 0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _focusMinutes = prefs.getInt(_kFocusKey) ?? _focusMinutes;
      _shortMinutes = prefs.getInt(_kShortKey) ?? _shortMinutes;
      _longMinutes = prefs.getInt(_kLongKey) ?? _longMinutes;
      _longEvery = prefs.getInt(_kLongEveryKey) ?? _longEvery;
      _remainingSeconds = _focusMinutes * 60;
    });
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kFocusKey, _focusMinutes);
    await prefs.setInt(_kShortKey, _shortMinutes);
    await prefs.setInt(_kLongKey, _longMinutes);
    await prefs.setInt(_kLongEveryKey, _longEvery);
  }

  void _startTimer() {
    if (_isRunning) return;
    setState(() => _isRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_remainingSeconds <= 0) {
        t.cancel();
        _onPhaseComplete();
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _remainingSeconds = _durationForPhase(_phase) * 60;
    });
  }

  void _switchPhase(TimerPhase phase) {
    _timer?.cancel();
    setState(() {
      _phase = phase;
      _isRunning = false;
      _remainingSeconds = _durationForPhase(phase) * 60;
    });
  }

  void _onPhaseComplete() {
    setState(() => _isRunning = false);
    if (_phase == TimerPhase.focus) {
      _completedFocus++;
      if (_completedFocus % _longEvery == 0) {
        _switchPhase(TimerPhase.longBreak);
      } else {
        _switchPhase(TimerPhase.shortBreak);
      }
    } else {
      _switchPhase(TimerPhase.focus);
    }
  }

  int _durationForPhase(TimerPhase phase) {
    switch (phase) {
      case TimerPhase.focus:
        return _focusMinutes;
      case TimerPhase.shortBreak:
        return _shortMinutes;
      case TimerPhase.longBreak:
        return _longMinutes;
    }
  }

  String get _phaseLabel {
    switch (_phase) {
      case TimerPhase.focus:
        return 'Focus';
      case TimerPhase.shortBreak:
        return 'Short Break';
      case TimerPhase.longBreak:
        return 'Long Break';
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalSeconds = _durationForPhase(_phase) * 60;
    final progress = totalSeconds == 0 ? 0.0 : 1 - (_remainingSeconds / totalSeconds);
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro Timer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettings(context),
            tooltip: 'Settings',
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _phaseLabel,
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _ProgressRing(
                progress: progress.clamp(0.0, 1.0),
                child: Text(
                  '$minutes:$seconds',
                  style: theme.textTheme.displaySmall?.copyWith(fontFeatures: const []),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  ElevatedButton.icon(
                    onPressed: _isRunning ? _pauseTimer : _startTimer,
                    icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                    label: Text(_isRunning ? 'Pause' : 'Start'),
                  ),
                  OutlinedButton.icon(
                    onPressed: _resetTimer,
                    icon: const Icon(Icons.restart_alt),
                    label: const Text('Reset'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('Focus'),
                    selected: _phase == TimerPhase.focus,
                    onSelected: (_) => _switchPhase(TimerPhase.focus),
                  ),
                  ChoiceChip(
                    label: const Text('Short Break'),
                    selected: _phase == TimerPhase.shortBreak,
                    onSelected: (_) => _switchPhase(TimerPhase.shortBreak),
                  ),
                  ChoiceChip(
                    label: const Text('Long Break'),
                    selected: _phase == TimerPhase.longBreak,
                    onSelected: (_) => _switchPhase(TimerPhase.longBreak),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text('Completed focus sessions: $_completedFocus'),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showSettings(BuildContext context) async {
    final focusCtrl = TextEditingController(text: _focusMinutes.toString());
    final shortCtrl = TextEditingController(text: _shortMinutes.toString());
    final longCtrl = TextEditingController(text: _longMinutes.toString());
    final everyCtrl = TextEditingController(text: _longEvery.toString());

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Settings', style: Theme.of(ctx).textTheme.titleLarge),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _NumberField(label: 'Focus (min)', controller: focusCtrl)),
                  const SizedBox(width: 8),
                  Expanded(child: _NumberField(label: 'Short break', controller: shortCtrl)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _NumberField(label: 'Long break', controller: longCtrl)),
                  const SizedBox(width: 8),
                  Expanded(child: _NumberField(label: 'Long every', controller: everyCtrl)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      final f = int.tryParse(focusCtrl.text) ?? _focusMinutes;
                      final s = int.tryParse(shortCtrl.text) ?? _shortMinutes;
                      final l = int.tryParse(longCtrl.text) ?? _longMinutes;
                      final e = int.tryParse(everyCtrl.text) ?? _longEvery;
                      setState(() {
                        _focusMinutes = f.clamp(1, 180);
                        _shortMinutes = s.clamp(1, 60);
                        _longMinutes = l.clamp(1, 120);
                        _longEvery = e.clamp(1, 12);
                        _remainingSeconds = _durationForPhase(_phase) * 60;
                      });
                      _savePrefs();
                      Navigator.pop(ctx);
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProgressRing extends StatelessWidget {
  final double progress; // 0..1
  final Widget child;

  const _ProgressRing({required this.progress, required this.child});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 220,
            height: 220,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 14,
              color: color,
              backgroundColor: color.withValues(alpha: 0.15),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _NumberField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const _NumberField({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
      inputFormatters: const [],
    );
  }
}
