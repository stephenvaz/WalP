import 'package:flutter/material.dart';
import 'login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Initial());
}

class Initial extends StatelessWidget {
  const Initial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Builder(builder: (context) {
        return Center(
            child: TextButton(
          child: const Text('Login Page'),
          onPressed: () {
            Fluttertoast.showToast(
        msg: "test message",
);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignInUp()),
            );
          },
        ));
      })),
    );
  }
}
