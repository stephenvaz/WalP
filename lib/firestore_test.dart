import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:walp/login.dart';
import 'package:walp/model/user_model.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
      if (user != null) {
        // this is your user instance
        /// is because there is user already logged
        return const Pf2();
      }

      /// other way there is no user logged.
      return const SignInUp();
    });
  }
}
class Pf2 extends StatefulWidget {
  const Pf2({ Key? key }) : super(key: key);

  @override
  _Pf2State createState() => _Pf2State();
}

class _Pf2State extends State<Pf2> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          constraints: const BoxConstraints.expand(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                Center(
                  child: Icon(
                    Icons.account_circle,
                    size: 80,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.badge,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    const Padding(padding: EdgeInsets.all(4)),
                    Center(
                        child: Text('${loggedInUser.name}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white.withOpacity(0.7),
                            )))
                  ],
                ),
                const Padding(padding: EdgeInsets.all(8)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    const Padding(padding: EdgeInsets.all(4)),
                    Center(
                        child: Text('${loggedInUser.email}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white.withOpacity(0.7),
                            )))
                  ],
                ),
                const Padding(padding: EdgeInsets.all(8)),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

