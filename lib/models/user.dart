class User {

  final String uid;

  User({this.uid});

}

class UserData {
  final String uid;
  final String businessName;
  final String name;
  final String tagline;
  final String jobTitle;
  final String website;
  final String email;
  final String phone;

  UserData({ this.uid, this.businessName, this.name, this.tagline, this.jobTitle,
    this.website, this.email, this.phone });
}