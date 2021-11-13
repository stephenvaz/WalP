import 'package:flutter/material.dart';
import 'package:walp/firestore_test.dart';
import 'reg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInUp extends StatefulWidget {
  const SignInUp({Key? key}) : super(key: key);

  @override
  _SignInUpState createState() => _SignInUpState();
}

class _SignInUpState extends State<SignInUp> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _passC = TextEditingController();

//firebase
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
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
            return ('Please enter email');
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        });

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
    final loginButton = ElevatedButton(
      onPressed: () {
        signIn(_emailC.text, _passC.text);
      },
      child: const Text('Login'),
      style: ElevatedButton.styleFrom(
        primary: Colors.white.withOpacity(0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
    final signUpButton = ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const SignUp()));
      },
      child: const Text('Sign Up'),
      style: ElevatedButton.styleFrom(
        primary: Colors.white.withOpacity(0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: email,
                    ),
                    const Padding(padding: EdgeInsets.all(8.0)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: pass,
                    ),
                    const Padding(padding: EdgeInsets.all(16.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        loginButton,
                        const Padding(padding: EdgeInsets.all(8.0)),
                        signUpButton,
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  //login fun
  void signIn(String email, String pass) async {
    if (formKey.currentState!.validate()) {
      await auth
          .signInWithEmailAndPassword(email: email, password: pass)
          .then((uid) => {
                Fluttertoast.showToast(msg: 'Login Successful'),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Profile()))
              })
          .catchError((e) => {
                Fluttertoast.showToast(msg: e!.message),
              });
    }
  }
}
