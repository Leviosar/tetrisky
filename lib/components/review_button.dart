import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../global/app_theme.dart';

class ReviewButton extends StatefulWidget {
  @override
  _ReviewButtonState createState() => _ReviewButtonState();
}

class _ReviewButtonState extends State<ReviewButton> {
  AppTheme theme = BlocProvider.getDependency<AppTheme>();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      child: Icon(Icons.star, color: theme.colors.green),
      onPressed: () {}
    );
  }
}