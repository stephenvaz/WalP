import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:walp/main.dart';
import 'package:walp/model/user_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _passC = TextEditingController();
  final TextEditingController _pass2C = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final name = TextFormField(
      controller: _name,
      onSaved: (value) => _name.text = value!,
      style: const TextStyle(color: Colors.white),
      autofocus: false,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.white,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Name',
        hintStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Name cannot be Empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid name(Min. 3 Character)");
        }
        return null;
      },
    );
    final email = TextFormField(
      style: const TextStyle(color: Colors.white),
      autofocus: false,
      controller: _emailC,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) => _emailC.text = value!,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.mark_email_unread,
          color: Colors.white,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Email',
        hintStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
    );
    final pass = TextFormField(
      style: const TextStyle(color: Colors.white),
      autofocus: false,
      controller: _passC,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      onSaved: (value) => _passC.text = value!,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.vpn_key,
          color: Colors.white,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Password',
        hintStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
    );

    final pass2 = TextFormField(
      style: const TextStyle(color: Colors.white),
      autofocus: false,
      controller: _pass2C,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      onSaved: (value) => _pass2C.text = value!,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.vpn_key,
          color: Colors.white,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Confirm Password',
        hintStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      validator: (value) {
        if (_pass2C.text != _passC.text) {
          return ("Password doesn't match");
        }
        return null;
      },
    );

    final signUpButton = ElevatedButton(
      onPressed: () {
        signUp(_emailC.text, _passC.text);
      },
      child: const Text('Sign Up'),
      style: ElevatedButton.styleFrom(
        primary: Colors.white.withOpacity(0.05),
      ),
    );

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage("https://i.gifer.com/7Ik1.gif"),
                  fit: BoxFit.fill),
            ),
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: name,
                      ),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: email,
                      ),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: pass,
                      ),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: pass2,
                      ),
                      signUpButton,
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String pass) async {
    if (formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: pass)
          .then((value) => {postDetailstoFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
//post detail fun yet to check if it works, everything else seems to work
  postDetailstoFirestore() async {
    //call firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    //fetch and assign to current user
    User? user = _auth.currentUser;
    //call user model
    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = _name.text;

    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: 'Account Created Successfully');

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Initial()),
        (route) => false);
  }
}
