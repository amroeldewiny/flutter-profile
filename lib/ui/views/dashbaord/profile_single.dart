import 'package:baobabart/core/services/database.dart';
import 'package:baobabart/ui/widgets/baobabbutton.dart';
import 'package:flutter/material.dart';
import 'package:baobabart/ui/widgets/baobabtheme.dart';
import 'package:baobabart/core/models/profile.dart';

class ProfileSingle extends StatelessWidget {
  final Profile profile;
  ProfileSingle({this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaobabTheme.primary,
      appBar: AppBar(
        title: Text(
          "Baobab Art",
          style: TextStyle(
            fontFamily: 'GreatVibes',
            fontSize: 40.0,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context, false),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: BaobabTheme.secondary,
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
                  backgroundImage: profile.image == null
                      ? profile.image
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
    );
  }
}
