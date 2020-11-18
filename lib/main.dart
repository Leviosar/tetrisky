import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'global/app_theme.dart';
import 'views/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        title: 'Fluttetris',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'FatCow'
        ),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
      dependencies: this.generateDependencies(),
    );
  }

  List<Dependency> generateDependencies() {
    return [
      Dependency((i) => AppTheme())
    ];
  }
}