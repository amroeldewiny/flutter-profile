import 'package:flutter/material.dart';
import 'package:baobabart/core/services/auth.dart';
import 'package:baobabart/core/services/database.dart';
import 'package:baobabart/core/models/profile.dart';
import 'package:baobabart/ui/widgets/baobabtheme.dart';
import 'package:provider/provider.dart';
import 'package:baobabart/ui/views/dashbaord/profile_list.dart';
import 'package:baobabart/ui/widgets/baobabappbar.dart';
import 'package:baobabart/ui/widgets/baobabdawer.dart';

class Dashboard extends StatelessWidget {
  final Profile profile;
  Dashboard({Key key, this.profile}) : super(key: key);
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();

  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Profile>>.value(
      value: _db.profiles,
      child: Scaffold(
        backgroundColor: BaobabTheme.primary,
        key: _drawerKey,
        drawer: BaobabDrawer(profile: this.profile),
        appBar: BaobabAppBar(
          title: 'Profiles',
          callback: () => _drawerKey.currentState.openDrawer(),
        ),
        body: Container(
          child: ProfilesList(),
        ),
      ),
    );
  }
}
