import 'dart:collection';

import 'package:flutter/material.dart';
import 'tetromino_icon.dart';
import '../models/tetromino.dart';

class TetrominoQueueDisplay extends StatelessWidget {

  final Queue<Tetromino> queue;

  const TetrominoQueueDisplay({Key key, this.queue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
          )
        ),
        child: Column(
          children: this.queue.map((Tetromino tetromino) => Padding(
            padding: EdgeInsets.all(6.0),
            child: TetrominoIcon(tetromino.type)
          )).toList()
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(140),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        )
      ),
    );
  }
}