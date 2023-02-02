import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/model/auth/authStatus.dart';
import 'package:socialapp/model/auth/userModel.dart';
import 'package:socialapp/view/widgets/toast.dart';

class AuthCubit extends Cubit<AuthAppStatus> {
  AuthCubit() : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);
  Future<dynamic> RegisterMethod({
    required String email,
    required String password,
    required String name,
  }) {
    emit(RegisterLoadingState());
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      CreateUser(
        email: email,
        uid: value.user!.uid,
        name: name,
        bio: 'write bio',
        cover: 'https://images.unsplash.com/file-1656361016116-55e06cbfced9image',
        image: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cG9ydHJhaXR8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60'
      );
      //print(value);
      emit(RegisterSuccessState(value.user!.uid));
    }).catchError((onError) {
      emit(RegisterErrorState());
    });
  }

  bool value = false;
  TermsCheckBox(bool v) {
    value = v;
    emit(checkBoxState());
  }

  bool obsecure = false;
  ChangeObsecure() {
    obsecure = !obsecure;
    emit(ObsecureState());
  }

  bool KeepSignedIn = false;
  KeepSignedInMethod(bool v) {
    KeepSignedIn = v;
    emit(checkBoxState());
  }

  LoginMethod({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((onError) {
      emit(LoginErrorState(onError.toString()));
    });
  }

  CreateUser({
    required String email,
    required String uid,
    required String name,
    required String image,
    required String cover,
    required String bio,
  }) {
    UserModel model = UserModel(
        email: email,
        name: name,
        uid: uid,
        bio: 'write your bio',
        cover: 'https://images.unsplash.com/file-1656361016116-55e06cbfced9image',
        image: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cG9ydHJhaXR8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60');
    FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .set(model.tojson())
        .then((value) {
      print(model);
      print('a333');

      emit(CreateUserSuccessState());
    }).catchError((onError) {
      emit(CreateUserErrorState());
    });
  }
}
