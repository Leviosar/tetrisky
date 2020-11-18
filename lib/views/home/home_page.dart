import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import '../../components/custom_raised_button.dart';
import '../../components/review_button.dart';
import '../../global/app_theme.dart';
import '../game/game_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppTheme theme = BlocProvider.getDependency<AppTheme>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlocProvider.getDependency<AppTheme>().colors.green,
      floatingActionButton: ReviewButton(),
      body: this.buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            children: [
              Expanded(
                child: CustomRaisedButton(
                  onPressed: () => this.gameStart(context),
                  child: Text(
                    "Play",
                    style: TextStyle(fontSize: 32.0),
                  ),
                  backgroundColor: Colors.white
                )
              )
            ]
          )
        )
      ],
    );
  }

  gameStart(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => GamePage())
    );
  }
}
