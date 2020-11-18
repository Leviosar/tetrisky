import 'package:flutter/material.dart';
import '../models/tetromino.dart';
import '../models/vector2.dart';

class TetrominoIcon extends StatelessWidget {
  final int pointSize = 5;
  final TetrominoType type;

  TetrominoIcon(this.type);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      width: (pointSize * 4).toDouble(),
      height: (pointSize * 2).toDouble(),
      child: Stack(children: this.buildPoints()),
    );
  }

  List<Positioned> buildPoints() {
    Tetromino tetromino = new Tetromino(this.type, Vector2(10, 20));
    return tetromino.icon(pointSize);
  }
}