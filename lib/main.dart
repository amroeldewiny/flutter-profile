import 'package:flutter/material.dart';
import 'package:baobabart/ui/views/wrapper.dart';
import 'package:baobabart/core/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:baobabart/core/models/user.dart';

void main() => runApp(Baobabart());

class Baobabart extends StatefulWidget {
  @override
  _BaobabartState createState() => _BaobabartState();
}

class _BaobabartState extends State<Baobabart> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
