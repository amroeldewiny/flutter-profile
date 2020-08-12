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

class UserTodo {
  final String uid;
  final String title;
  final String discription;
  final bool done;
  UserTodo({this.uid, this.title, this.discription, this.done});
}
