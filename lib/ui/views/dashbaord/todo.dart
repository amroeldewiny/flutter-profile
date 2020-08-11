import 'package:flutter/material.dart';
import 'package:baobabart/ui/widgets/baobabtheme.dart';
import 'package:baobabart/ui/widgets/baobabappbar.dart';
import 'package:baobabart/ui/widgets/baobabdawer.dart';

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: BaobabDrawer(),
      backgroundColor: BaobabTheme.primary,
      appBar: BaobabAppBar(
        title: 'Todo',
        callback: () => _drawerKey.currentState.openDrawer(),
      ),
      body: Container(
        child: Center(
          child: Text('Todo'),
        ),
      ),
    );
  }
}
