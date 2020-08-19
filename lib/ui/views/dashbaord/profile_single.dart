import 'package:flutter/material.dart';
import 'package:baobabart/ui/widgets/baobabtheme.dart';
import 'package:baobabart/ui/widgets/baobabappbar.dart';
import 'package:baobabart/ui/widgets/baobabdawer.dart';
import 'package:baobabart/core/models/profile.dart';

class ProfileSingle extends StatelessWidget {
  final Profile profile;
  ProfileSingle({Key key, this.profile}) : super(key: key);
  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: BaobabDrawer(profile: this.profile),
      backgroundColor: BaobabTheme.primary,
      appBar: BaobabAppBar(
        title: 'Profile',
        callback: () => _drawerKey.currentState.openDrawer(),
      ),
      //body: Center(child: Text(userProfile.email)),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.transparent,
                  backgroundImage: profile.image != null
                      ? Image.network(profile.image).image
                      : Image.asset('assets/images/no_user.png').image,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  profile.name,
                  textScaleFactor: 3,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(profile.uid),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      profile.email,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      profile.job,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: Text('Chat'),
        icon: Icon(Icons.chat_bubble),
        backgroundColor: BaobabTheme.dark,
      ),
    );
  }
}
