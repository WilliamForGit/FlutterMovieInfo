import 'package:MoviePKR/screens/mainPage/widgets/MovieList.dart';
import 'package:MoviePKR/screens/mainPage/widgets/SliverBar.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
          colors: [
            AppColors.secondaryColor.withOpacity(0.87),
            AppColors.primaryColor
          ],
        ),
      ),
      child: Scaffold(
          resizeToAvoidBottomPadding: true,
          backgroundColor: Colors.transparent,
          body: CustomScrollView(
            slivers: <Widget>[SliverBar(), movieList(context)],
          )),
    );
  }
}
