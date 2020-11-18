import 'package:flutter/material.dart';

import '../models/tetromino.dart';
import 'tetromino_icon.dart';

class TetrominoHoldDisplay extends StatelessWidget {
  
  final Tetromino tetrominoOnHold;

  const TetrominoHoldDisplay(this.tetrominoOnHold);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Hold", style: TextStyle(fontSize: 25.0)),
        Container(
          padding: EdgeInsets.only(bottom: 6.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              )
            ),
            child: Padding(
              padding: EdgeInsets.all(6.0),
              child: this.tetrominoOnHold != null ? TetrominoIcon(this.tetrominoOnHold.type) : Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                width: 20,
                height: 10,
              )
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(140),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
            )
          ),
        )
      ]
    );
  }
}