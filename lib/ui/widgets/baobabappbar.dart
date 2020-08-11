import 'package:flutter/material.dart';
import 'package:baobabart/core/services/auth.dart';
import 'package:baobabart/ui/widgets/baobabtheme.dart';

class BaobabAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AuthService _auth = AuthService();
  final String title;
  final VoidCallback callback;

  BaobabAppBar({this.title, this.callback})
      : preferredSize = Size.fromHeight(60.0);
  @override
  final Size preferredSize;
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: BaobabTheme.secondary,
      elevation: 0,
      title: Text(title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: callback,
        ),
      ],
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context, false),
      ),
      centerTitle: true,
    );
  }
}
