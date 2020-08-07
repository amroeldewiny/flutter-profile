import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baobabart/core/models/profile.dart';
import 'package:baobabart/ui/views/dashbaord/profile_title.dart';

class ProfilesList extends StatefulWidget {
  @override
  _ProfilesListState createState() => _ProfilesListState();
}

class _ProfilesListState extends State<ProfilesList> {
  @override
  Widget build(BuildContext context) {
    final profiles = Provider.of<List<Profile>>(context) ?? [];

    return ListView.builder(
      itemCount: profiles.length,
      itemBuilder: (context, index) {
        return ProfileTitle(profile: profiles[index]);
      },
    );
  }
}
