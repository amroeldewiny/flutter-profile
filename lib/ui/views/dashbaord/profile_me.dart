import 'package:flutter/material.dart';
import 'package:baobabart/core/models/user.dart';
import 'package:baobabart/core/services/database.dart';
import 'package:provider/provider.dart';
import 'package:baobabart/ui/widgets/baobabappbar.dart';
import 'package:baobabart/ui/widgets/baobabdawer.dart';
import 'package:baobabart/ui/widgets/baobabloading.dart';
import 'package:baobabart/ui/views/dashbaord/dashboard.dart';
import 'package:baobabart/ui/widgets/baobabbutton.dart';
import 'package:baobabart/ui/widgets/baobabinput.dart';
import 'package:baobabart/ui/widgets/baobabtheme.dart';

class ProfileMe extends StatefulWidget {
  @override
  _ProfileMeState createState() => _ProfileMeState();
}

class _ProfileMeState extends State<ProfileMe> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

  // form values
  String currentName;
  String currentJob;
  String currentImage;
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      key: _drawerKey,
      drawer: BaobabDrawer(),
      backgroundColor: BaobabTheme.primary,
      appBar: BaobabAppBar(
        title: 'Edit Profile',
        callback: () => _drawerKey.currentState.openDrawer(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<UserProfile>(
          stream: DatabaseService(uid: user.uid).userProfile,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserProfile userProfile = snapshot.data;
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Center(
                        child: Text(
                          'Update Your Profile',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontFamily: 'GreatVibes',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                      child: Stack(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                              child: currentImage != null
                                  ? userProfile.image
                                  : Image.asset(
                                      'assets/images/no_user.png',
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: 1,
                            right: 1,
                            child: Container(
                              height: 40,
                              width: 40,
                              child: Icon(
                                Icons.add_a_photo,
                                color: BaobabTheme.primary,
                              ),
                              decoration: BoxDecoration(
                                  color: BaobabTheme.secondary,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      style: BaobabFieldStyle(),
                      initialValue: userProfile.name,
                      validator: (value) =>
                          value.isEmpty ? 'Enter an name' : null,
                      onChanged: (value) =>
                          setState(() => currentName = value.trim()),
                      decoration: BaobabInputDecoration(
                          "Enter your name....", Icons.person_add),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      style: BaobabFieldStyle(),
                      initialValue: userProfile.job,
                      validator: (value) =>
                          value.isEmpty ? 'Enter an job' : null,
                      onChanged: (value) =>
                          setState(() => currentJob = value.trim()),
                      decoration: BaobabInputDecoration(
                          "Enter your job....", Icons.business_center),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    BaobabButton(
                      text: 'Update your profile',
                      callback: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                            user.uid,
                            currentName ?? snapshot.data.name,
                            userProfile.email,
                            currentJob ?? snapshot.data.name,
                            userProfile.image,
                          );
                          await Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard(
                                      //profile: this.profile,
                                      )));
                        }
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
