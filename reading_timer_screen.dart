import 'dart:async';
import 'package:flutter/material.dart';
import '../models/book.dart';

class ReadingTimerScreen extends StatefulWidget {
  final Book book;

  ReadingTimerScreen({required this.book});

  @override
  State<ReadingTimerScreen> createState() => _ReadingTimerScreenState();
}

class _ReadingTimerScreenState extends State<ReadingTimerScreen> {
  Timer? _timer;
  int _sessionSeconds = 0;
  bool _isRunning = false;
  Set<int> _awardedSeconds = {};

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int totalSeconds) {
    int h = totalSeconds ~/ 3600;
    int m = (totalSeconds % 3600) ~/ 60;
    int s = totalSeconds % 60;
    if (h > 0) return '${h}h ${m}m ${s}s';
    if (m > 0) return '${m}m ${s}s';
    return '${s}s';
  }

  String _getMedal(int seconds) {
    if (seconds >= 60) return '🏅 Medalha Ouro';
    if (seconds >= 50) return '🥈 Medalha Prata';
    if (seconds >= 30) return '🥉 Medalha Bronze';
    return '';
  }

  void _startTimer() {
    if (_isRunning) return;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _sessionSeconds++;
      });

      int totalTime = widget.book.totalSecondsRead + _sessionSeconds;
      if ((totalTime == 30 || totalTime == 50 || totalTime == 60) &&
          !_awardedSeconds.contains(totalTime)) {
        _awardedSeconds.add(totalTime);
        String medal = _getMedal(totalTime);
        if (medal.isNotEmpty) {
          widget.book.medals.add(medal);
          _showMedalDialog(medal);
        }
      }
    });

    setState(() => _isRunning = true);
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _resetSession() {
    _pauseTimer();
    setState(() {
      _sessionSeconds = 0;
      _awardedSeconds.clear();
    });
  }

  void _finishSession() {
    widget.book.totalSecondsRead += _sessionSeconds;
    _pauseTimer();
    Navigator.pop(context);
  }

  void _showMedalDialog(String medal) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Parabéns!'),
        content: Text('Você ganhou: $medal'),
        actions: [
          TextButton(
            child: Text('Continuar lendo'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String sessionTimeStr = _formatTime(_sessionSeconds);
    String totalTimeStr = _formatTime(widget.book.totalSecondsRead + _sessionSeconds);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lendo: ${widget.book.name}'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            tooltip: 'Finalizar sessão',
            onPressed: _finishSession,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tempo da Sessão', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
            Text(sessionTimeStr, style: TextStyle(fontSize: 56, color: Colors.deepPurple, fontWeight: FontWeight.bold)),
            SizedBox(height: 40),
            Text('Tempo Total Lido no Livro', style: TextStyle(fontSize: 18)),
            Text(totalTimeStr, style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500)),
            SizedBox(height: 40),
            Wrap(
              spacing: 15,
              children: [
                ElevatedButton.icon(
                  icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                  label: Text(_isRunning ? 'Pausar' : 'Iniciar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isRunning ? Colors.red : Colors.green,
                    minimumSize: Size(140, 48),
                  ),
                  onPressed: _isRunning ? _pauseTimer : _startTimer,
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.restart_alt),
                  label: Text('Resetar Sessão'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[600],
                    minimumSize: Size(140, 48),
                  ),
                  onPressed: _resetSession,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
