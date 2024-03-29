import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:hnefatafl/pages/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) {
                if(input.isEmpty){
                  return 'Please type an email';
                }
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                labelText: 'Email',
              )
            ),
            TextFormField(
              validator: (input) {
                if(input.length < 6){
                  return 'Your password needs to be atleast 6 cheracters ';
                }
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: signIn,
              child: Text('Sign in'),
            )
          ],
        )
      )
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    print('here');
    if(formState.validate()){
      formState.save();
      try {
        print('here'+_email+'___'+_password);
        AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Home(user: user.user),
        ));
        print(user.user.toString());
      } catch(e){
        print(e.toString());
      }
    }
  }
}