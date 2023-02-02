class UserModel {
  String? name;
  String? email;
  String? uid;
  String? image;
  String? cover;
  String? bio;
  UserModel({
    this.email,
    this.name,
    this.uid,
    this.bio,
    this.cover,
    this.image,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    uid = json['uid'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
  }
  Map<String, dynamic> tojson() {
    return {
      'name': name,
      'email': email,
      'uid': uid,
      'image':image,
      'cover':cover,
      'bio':bio,
    };
  }
}
