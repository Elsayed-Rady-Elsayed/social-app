import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/consts.dart';
import 'package:socialapp/model/Home/HomeStatus.dart';
import 'package:socialapp/model/Home/PostModel.dart';
import 'package:socialapp/model/Home/messageModel.dart';
import 'package:socialapp/model/auth/userModel.dart';
import 'package:socialapp/view/screens/Home/ChatScreen.dart';
import 'package:socialapp/view/screens/Home/NewpostScreen.dart';
import 'package:socialapp/view/screens/Home/HomeScreen.dart';
import 'package:socialapp/view/screens/Home/settingsScreen.dart';
import 'package:socialapp/view/screens/Home/usersScreen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class HomeCubit extends Cubit<HomeAppStatus> {
  HomeCubit() : super(HomeAppInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  UserModel? USERmodel;
  TextEditingController bioController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  GetUserData() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('user').doc(uid).get().then((value) {
      USERmodel = UserModel.fromJson(value.data()!);
      bioController.text = USERmodel!.bio!;
      nameController.text = USERmodel!.name!;
      emit(GetUserSuccessState());
    }).catchError((e) {
      emit(GetUserErrorState());
    });
  }

  int currentIndex = 0;

  void ChangeTheCurrentIndex(int value) {
    currentIndex = value;
    emit(ChangeBottomNavBarIndexState());
  }

  List<Widget> screens = [
    PostsScreen(),
    ChatsScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'home',
    'chats',
    'users',
    'settings',
  ];
  var picker = ImagePicker();
  File? profileImage;
  Future<void> GetProfileImage() async {
    final PickedFile = await picker.getImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      profileImage = File(PickedFile.path);
      emit(PickProfileImageSuccessState());
    } else {
      print('not picked');
      emit(PickProfileImageErrorState());
    }
  }

  File? CoverImage;
  Future<void> GetCoverImage() async {
    final PickedFile = await picker.getImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      CoverImage = File(PickedFile.path);
      emit(PickCoverImageSuccessState());
    } else {
      print('not picked');
      emit(PickCoverImageErrorState());
    }
  }

  String? profileImageUrl;
  void uplodeProfileImage({required String name, required String bio}) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        UpdateUser(name: name, bio: bio, image: value);
        GetUserData();
        emit(UplodprofileImageSuccessState());
      }).catchError((onError) {
        emit(UplodekprofilemageErrorState());
      });
    }).catchError((e) {});
  }

  String? coverImageUrl;
  void uplodecoverImage({required String name, required String bio}) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(CoverImage!.path).pathSegments.last}')
        .putFile(CoverImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        UpdateUser(name: name, bio: bio, cover: value);
        GetUserData();
        emit(UplodprofileImageSuccessState());
      }).catchError((onError) {
        emit(UplodekprofilemageErrorState());
      });
    }).catchError((e) {});
  }

  void UpdateUser(
      {required String name,
      required String bio,
      String? cover,
      String? image}) {
    UserModel model1 = UserModel(
        email: USERmodel!.email,
        name: name,
        uid: USERmodel!.uid,
        bio: bio,
        cover: cover ?? USERmodel!.cover,
        image: image ?? USERmodel!.image);
    FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .update(model1.tojson())
        .then((value) {
      GetUserData();
      emit(UpdateUserDataState());
    }).catchError((onError) {});
  }

  File? PostImage;
  Future<void> GetPostImage() async {
    final PickedFile = await picker.getImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      PostImage = File(PickedFile.path);
      emit(PickpostImageSuccessState());
    } else {
      print('not picked');
      emit(PickpostImageErrorState());
    }
  }

  void uplodePostImage({
    String? name,
    String? uid,
    String? image,
    String? text,
    String? dateTime,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('post/${Uri.file(PostImage!.path).pathSegments.last}')
        .putFile(PostImage!)
        .then((p0) {
      p0.ref.getDownloadURL().then((value) {
        CreatePost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
        emit(UplodePostImageSuccessState());
      }).catchError((onError) {
        emit(UplodePostImageErrorState());
      });
    }).catchError((e) {});
  }

  TextEditingController postController = TextEditingController();
  void CreatePost({
    String? postImage,
    required String? text,
    required String? dateTime,
  }) {
    PostModel postModel = PostModel(
      dateTime: dateTime,
      image: USERmodel!.image,
      name: USERmodel!.name,
      uid: USERmodel!.uid,
      postImage: postImage ?? '',
      text: text,
    );
    FirebaseFirestore.instance
        .collection('post')
        .add(postModel.tojson())
        .then((value) {
      getPosts();
      emit(CreatePostState());
    }).catchError((onError) {});
  }

  void RemovePostimage() {
    PostImage = null;
    emit(RemoveimageState());
  }

  List<PostModel> posts = [];
  List<String> postids = [];
  List<int> likes = [];
  getPosts() {
    FirebaseFirestore.instance.collection('post').get().then((value) {
      value.docs.forEach((e) {
        e.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postids.add(e.id);
          posts.add(PostModel.fromJson(e.data()));
          emit(GetPostsSucessState());
        }).catchError((e) {});
      });
      emit(GetPostsSucessState());
    }).catchError((e) {
      emit(GetPostsErrorState());
    });
  }

  void LikePost(String postId) {
    FirebaseFirestore.instance
        .collection('post')
        .doc(postId)
        .collection('likes')
        .doc(uid)
        .set({
      'like': true,
    }).then((value) {
      emit(LikePostSuccessState());
    }).catchError((onError) {
      emit(LikePostErrorState());
    });
  }

  List<UserModel> users = [];
  void GetUsers() {
    FirebaseFirestore.instance.collection('user').get().then((value) {
      value.docs.forEach((element) {
        users.add(UserModel.fromJson(element.data()));
      });
      emit(GetusersSuccessState());
    }).catchError((value) {
      emit(GetusersErrorState());
    });
  }

  void sendMessageme({
    required String reciever,
    required String text,
    required String dateTime,
  }) {
    MessageModel messageModel = MessageModel(
        text: text, sender: uid, reciever: reciever, dateTime: dateTime);

    //my chat
    FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('chat')
        .doc(reciever)
        .collection('messages')
        .add(messageModel.tojson())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((e) {
      emit(SendMessageErrorState());
    });
    // the reciever chat
    FirebaseFirestore.instance
        .collection('user')
        .doc(reciever)
        .collection('chat')
        .doc(uid)
        .collection('messages')
        .add(messageModel.tojson())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((e) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messageModel = [];
  getMessages({
    required String reciever,
  }) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('chat')
        .doc(reciever)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messageModel = [];
      event.docs.forEach((e) {
        messageModel.add(MessageModel.fromJson(e.data()));
      });
      emit(GetMessageSuccessState());
    });
  }
}
