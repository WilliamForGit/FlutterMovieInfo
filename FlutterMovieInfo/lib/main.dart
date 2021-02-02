import 'package:MoviePKR/providers/movieLists_provider.dart';
import 'package:MoviePKR/screens/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieLists(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MoviePKR',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainSplashScreen(),
      ),
    );
  }
}
