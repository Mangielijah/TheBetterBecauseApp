import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:the_better_because/screens/stories.screen.dart';
import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.name,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(

        seconds: 4,
        backgroundColor: Colors.yellowAccent,
        navigateAfterSeconds: StoriesPage(),
        title: Text(
          Constants.name,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        loaderColor: Colors.yellowAccent,
        loadingText: Text(
          Constants.version,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
