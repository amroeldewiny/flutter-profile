import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:baobabart/core/models/user.dart';
import 'package:baobabart/core/services/database.dart';
import 'package:provider/provider.dart';
import 'package:baobabart/ui/widgets/baobabappbar.dart';
import 'package:baobabart/ui/widgets/baobabdawer.dart';
import 'package:baobabart/ui/widgets/baobabloading.dart';
import 'package:image_picker/image_picker.dart';
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
  File imageFile;
  String currentName;
  String currentJob;
  String currentImage;

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      currentImage = downloadUrl;
      setState(() {
        currentImage = downloadUrl;
      });
    });
  }

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
                                  ? Image.network(
                                      currentImage,
                                      fit: BoxFit.cover,
                                    )
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
                            child: GestureDetector(
                              onTap: () async {
                                return showCupertinoModalPopup<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoActionSheet(
                                      title: Text('Profile Upload'),
                                      message: Text(
                                          'Please select your profile image form gallery or camera.'),
                                      actions: <Widget>[
                                        CupertinoActionSheetAction(
                                          child: Text('Gallery'),
                                          isDefaultAction: true,
                                          onPressed: () async {
                                            var image =
                                                await ImagePicker.pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            setState(() {
                                              imageFile = image;
                                            });
                                            uploadFile();
                                            Navigator.pop(context);
                                          },
                                        ),
                                        CupertinoActionSheetAction(
                                          child: Text('Camera'),
                                          isDefaultAction: true,
                                          onPressed: () async {
                                            var image =
                                                await ImagePicker.pickImage(
                                                    source: ImageSource.camera);
                                            setState(() {
                                              imageFile = image;
                                            });
                                            uploadFile();
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                      cancelButton: CupertinoActionSheetAction(
                                        isDefaultAction: true,
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
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
                            ),
                          ),
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
                            currentJob ?? snapshot.data.job,
                            currentImage ?? snapshot.data.image,
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
