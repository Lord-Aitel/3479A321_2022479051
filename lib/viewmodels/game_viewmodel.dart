import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../models/cell_model.dart';

class GameViewModel extends ChangeNotifier {
  final AudioPlayer _sfxPlayer = AudioPlayer();
  final int gridSize;
  late List<CellModel> _cells;
  StreamSubscription? _accelerometerSubscription;

  bool _isGameOver = false;
  int secondsElapsed = 0;
  Timer? _timer;

  GameViewModel({required this.gridSize}) {
    _generateBoard();
    _initAccelerometer();
    _startTimer();
  }

  // 👇 Getter para usar en la pantalla
  bool get isGameOver => _isGameOver;

  void _generateBoard() {
    _cells = List.generate(
      gridSize * gridSize,
      (index) => CellModel(hasMine: index % 7 == 0),
    );
    _isGameOver = false;
    secondsElapsed = 0;
  }

  bool hasMine(int index) => _cells[index].hasMine;
  bool isRevealed(int index) => _cells[index].isRevealed;

  void onCellTap(int index) {
    if (_isGameOver) return;

    _cells[index].isRevealed = true;

    if (_cells[index].hasMine) {
      _playSound('explosion.mp3');
      _isGameOver = true;
      _stopTimer();
    } else {
      _playSound('click.mp3');
    }

    notifyListeners();
  }

  void _playSound(String fileName) async {
    await _sfxPlayer.stop();
    await _sfxPlayer.play(AssetSource('audio/$fileName'));
  }

  void _initAccelerometer() {
    _accelerometerSubscription = accelerometerEventStream().listen((event) {
      if (_isGameOver && event.x.abs() > 15.0) {
        _resetGame();
      }
    });
  }

  void _resetGame() {
    _generateBoard();
    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_isGameOver) {
        secondsElapsed++;
        notifyListeners();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    _sfxPlayer.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
