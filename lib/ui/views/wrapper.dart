import 'package:baobabart/core/models/user.dart';
import 'package:baobabart/ui/views/authenticate/authenticate.dart';
import 'package:baobabart/ui/views/dashbaord/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return user != null ? Dashboard() : Authenticate();
  }
}
