import 'package:flutter/material.dart';
import 'package:walp/explore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Splash());
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WalP',
      home: AnimatedSplashScreen(
        duration: 500,
        splash: const Icon(
          Icons.landscape,
          size: 100,
          color: Colors.white,
        ),
        nextScreen: const Explore(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.black,
      ),
    );
  }
}

