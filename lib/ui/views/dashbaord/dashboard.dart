import 'package:flutter/material.dart';
import 'package:baobabart/core/services/auth.dart';
import 'package:baobabart/core/services/database.dart';
import 'package:baobabart/core/models/profile.dart';
import 'package:baobabart/ui/widgets/baobabtheme.dart';
import 'package:provider/provider.dart';
import 'package:baobabart/ui/views/dashbaord/profile_list.dart';

class Dashboard extends StatelessWidget {
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Profile>>.value(
      value: _db.profiles,
      child: Scaffold(
        backgroundColor: BaobabTheme.primary,
        appBar: AppBar(
          title: Text(
            "Baobab Art",
            style: TextStyle(
              fontFamily: 'GreatVibes',
              fontSize: 40.0,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
          elevation: 0,
          centerTitle: true,
          backgroundColor: BaobabTheme.secondary,
        ),
        body: Container(
          child: ProfilesList(),
        ),
      ),
    );
  }
}

/*        leading: IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await _auth.signOut();
            },
          ),* */
