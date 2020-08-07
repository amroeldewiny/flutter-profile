import 'package:flutter/material.dart';
import 'package:baobabart/core/services/auth.dart';
import 'package:baobabart/ui/widgets/baobabtheme.dart';
import 'package:baobabart/ui/widgets/baobabloading.dart';
import 'package:baobabart/ui/widgets/baobabinput.dart';
import 'package:baobabart/ui/widgets/baobabbutton.dart';

class Register extends StatefulWidget {
  final toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                    TextFormField(
                      style: BaobabFieldStyle(),
                      autocorrect: false,
                      obscureText: true,
                      onChanged: (value) => setState(() => conPass = value),
                      decoration: BaobabInputDecoration(
                          "Confirm your password....", Icons.vpn_key),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    BaobabButton(
                      text: 'Register',
                      callback: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          if (password == conPass) {
                            dynamic result =
                                await _auth.registerUser(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = error.toString();
                              });
                            }
                          } else {
                            loading = false;
                            error = 'Your password did\'t match';
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
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
                            "SignIn now",
                            style: TextStyle(
                                color: BaobabTheme.secondary,
                                fontSize: 14,
                                decoration: TextDecoration.underline),
                          ),
                        ),
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
