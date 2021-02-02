import 'dart:async';
import 'dart:io';
import 'package:MoviePKR/providers/movieLists_provider.dart';
import 'package:MoviePKR/screens/mainPage/main_page.dart';
import 'package:MoviePKR/screens/savedLists/savedLists_screen.dart';
import 'package:MoviePKR/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

class MainSplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  Future<Widget> loadFromFuture() async {
    try {
      await Provider.of<MovieLists>(context, listen: false)
          .fetchTrendingList()
          .timeout(Duration(minutes: 1));
      await Provider.of<MovieLists>(context, listen: false)
          .fetchGenres()
          .timeout(Duration(minutes: 1));
    } catch (_) {
      // return Future.value(SavedList());

      return showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Connection interrupted'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Please check your internet connection then try again.'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Exit'),
                onPressed: () {
                  exit(0);
                },
              ),
            ],
          );
        },
      );
    }
    try {
      await Provider.of<MovieLists>(context, listen: false)
          .fetchSavedListsFromSF();
    } catch (error) {
      print('Error in Shared preferences data-fetching $error');
    }
    return Future.value(new MyHomePage(title: 'MoviePKR2'));
  }

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      navigateAfterFuture: loadFromFuture(),
      gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [AppColors.primaryColor, AppColors.secondaryColor]),
      image: Image.asset(
        'assets/images/logo.png',
      ),
      photoSize: 160,
    );
  }
}
