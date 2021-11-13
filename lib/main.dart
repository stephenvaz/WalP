import 'package:flutter/material.dart';
import 'package:walp/explore.dart';
import 'package:walp/firestore_test.dart';
import 'login.dart';
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
        nextScreen: const Initial(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.black,
      ),
    );
  }
}

class Initial extends StatefulWidget {
  const Initial({Key? key}) : super(key: key);

  @override
  _InitialState createState() => _InitialState();
}

class _InitialState extends State<Initial> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/gif/login.gif'), fit: BoxFit.fill)),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.transparent,
            body: Builder(builder: (context) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextButton(
                      child: const Text('Profile Page'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Profile()),
                        );
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(12)),
                    TextButton(
                      child: const Text('Login Page'),
                      style: const ButtonStyle(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInUp()),
                        );
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(12)),
                    TextButton(
                      child: const Text('Explore Page'),
                      style: const ButtonStyle(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Explore()),
                        );
                      },
                    ),
                  ]);
            })),
      ),
    );
  }
}
