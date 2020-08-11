class User {
  final String uid;
  User({this.uid});
}

class UserProfile {
  final String uid;
  final String name;
  final String email;
  final String job;
  final String image;
  UserProfile({this.uid, this.name, this.email, this.job, this.image});
}
