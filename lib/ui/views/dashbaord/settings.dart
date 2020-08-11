import 'package:flutter/material.dart';
import 'package:baobabart/core/models/profile.dart';
import 'package:baobabart/ui/widgets/baobabtheme.dart';
import 'package:baobabart/ui/widgets/baobabappbar.dart';
import 'package:baobabart/ui/widgets/baobabdawer.dart';

class Settings extends StatefulWidget {
  final Profile profile;
  Settings({Key key, this.profile}) : super(key: key);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: BaobabDrawer(),
      backgroundColor: BaobabTheme.primary,
      appBar: BaobabAppBar(
        title: 'Settings',
        callback: () => _drawerKey.currentState.openDrawer(),
      ),
      body: Container(
        child: Center(
          child: Text('Settings'),
        ),
      ),
    );
  }
}
