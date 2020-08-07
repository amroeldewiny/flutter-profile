import 'package:flutter/material.dart';
import 'package:baobabart/core/models/profile.dart';
import 'package:baobabart/ui/views/dashbaord/profile_single.dart';

class ProfileTitle extends StatelessWidget {
  final Profile profile;
  ProfileTitle({this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('assets/images/no_user.png'),
          ),
          title: Text(profile.name),
          subtitle: Text('Email address:  ${profile.email}'),
          onTap: () {
            //print(profile.email);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileSingle(profile: profile)));
          },
        ),
      ),
    );
  }
}
