import 'package:flutter/material.dart';
import 'package:baobabart/core/services/auth.dart';
import 'package:baobabart/core/services/database.dart';
import 'package:baobabart/core/models/profile.dart';
import 'package:baobabart/core/models/user.dart';
import 'package:baobabart/ui/views/dashbaord/dashboard.dart';
import 'package:baobabart/ui/views/dashbaord/profile_single.dart';
import 'package:baobabart/ui/views/dashbaord/todo.dart';
import 'package:baobabart/ui/views/dashbaord/settings.dart';
import 'package:provider/provider.dart';

class BaobabDrawer extends StatefulWidget {
  final Profile profile;
  BaobabDrawer({Key key, this.profile}) : super(key: key);
  @override
  _BaobabDrawerState createState() => _BaobabDrawerState(profile: profile);
}

class _BaobabDrawerState extends State<BaobabDrawer> {
  _BaobabDrawerState({Key key, this.profile});
  final Profile profile;
  final AuthService _auth = AuthService();
  bool loading = false;
  bool isLoggedIn = false;

  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserProfile>(
      stream: DatabaseService(uid: user.uid).userProfile,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserProfile userProfile = snapshot.data;
          return Drawer(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(8.0, 50.0, 8.0, 8.0),
                  color: Colors.white,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.asset(
                          "assets/images/no_user.png",
                          width: 60.0,
                          height: 60.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: userProfile.email != null
                                  ? userProfile.email
                                  : 'User Profile',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Lato',
                                  color: Colors.grey[600])),
                        ]),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey[300],
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Column(
                    children: [
                      ListTile(
                        dense: true,
                        title: Text(
                          "Home",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        leading: Icon(Icons.home),
                        onTap: () async {
                          await Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard(
                                        profile: this.profile,
                                      )));
                        },
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                          "Profile",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        leading: Icon(Icons.person),
                        onTap: () async {
                          await Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileSingle(
                                        profile: this.profile,
                                      )));
                        },
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                          "Todo",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        leading: Icon(Icons.apps),
                        onTap: () async {
                          await Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Todo(
                                        profile: this.profile,
                                      )));
                        },
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                          "Settings",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        leading: Icon(Icons.settings),
                        onTap: () async {
                          await Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Settings(
                                        profile: this.profile,
                                      )));
                        },
                      ),
                      ListTile(
                        dense: true,
                        title: Text(
                          "Logout",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        leading: Icon(Icons.exit_to_app),
                        onTap: () async {
                          _auth.signOut();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
