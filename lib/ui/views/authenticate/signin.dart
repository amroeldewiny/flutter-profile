import 'package:baobabart/ui/views/dashbaord/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:baobabart/core/services/auth.dart';
import 'package:baobabart/ui/widgets/baobabtheme.dart';
import 'package:baobabart/ui/widgets/baobabloading.dart';
import 'package:baobabart/ui/widgets/baobabinput.dart';
import 'package:baobabart/ui/widgets/baobabbutton.dart';

class SignIn extends StatefulWidget {
  final toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  String email;
  String password;
  String conPass;

  @override
  Widget build(BuildContext context) {
    return loading
        ? BaobabLoading()
        : Scaffold(
            backgroundColor: BaobabTheme.primary,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: BaobabTheme.primary,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Baobab Art",
                        style: TextStyle(
                          color: BaobabTheme.secondary,
                          fontFamily: 'GreatVibes',
                          fontSize: 60.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      style: BaobabFieldStyle(),
                      validator: (value) =>
                          value.isEmpty ? 'Enter an email' : null,
                      onChanged: (value) =>
                          setState(() => email = value.trim()),
                      decoration: BaobabInputDecoration(
                          "Enter your email....", Icons.email),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      style: BaobabFieldStyle(),
                      autocorrect: false,
                      obscureText: true,
                      validator: (value) => value.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (value) =>
                          setState(() => password = value.trim()),
                      decoration: BaobabInputDecoration(
                          "Enter your password....", Icons.vpn_key),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    BaobabButton(
                      text: 'Login',
                      callback: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result =
                              await _auth.signInUser(email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: Text(
                                          'Please Check you email Or your password'),
                                    );
                                  });
                              //error = error.toString();
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have account? ",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.toggleView();
                          },
                          child: Text(
                            "Register now",
                            style: TextStyle(
                                color: BaobabTheme.secondary,
                                fontSize: 14,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboard()));
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 14,
                                    decoration: TextDecoration.underline),
                              )),
                        )
                      ],
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(
                          color: Colors.redAccent[100], fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
