import 'dart:math';

import '../models/tetromino.dart';
import '../models/vector2.dart';

class TetrominoPicker {
  static Tetromino pick(Vector2 screen) {
    TetrominoType type = TetrominoType.values[Random().nextInt(7)];
  
    return new Tetromino(type, screen);
  }
}