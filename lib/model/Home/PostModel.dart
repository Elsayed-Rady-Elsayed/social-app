class PostModel {
  String? name;
  String? uid;
  String? image;
  String? postImage;
  String? text;
  String? dateTime;


  PostModel({
    this.name,
    this.uid,
    this.image,
    this.postImage,
    this.text,
    this.dateTime,

  });
  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    image = json['image'];
    postImage = json['postImage'];
    text = json['text'];
    dateTime = json['dateTime'];

  }
  Map<String, dynamic> tojson() {
    return {
      'name': name,
      'uid': uid,
      'image': image,
      'postImage': postImage,
      'text': text,
      'dateTime': dateTime,
    };
  }
}
