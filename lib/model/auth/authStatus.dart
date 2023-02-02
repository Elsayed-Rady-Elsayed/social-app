abstract class AuthAppStatus {}

class AuthInitialState extends AuthAppStatus {}

class RegisterSuccessState extends AuthAppStatus {
  final String uid;
  RegisterSuccessState(this.uid);
}

class RegisterErrorState extends AuthAppStatus {}

class RegisterLoadingState extends AuthAppStatus {}

class checkBoxState extends AuthAppStatus {}

class ObsecureState extends AuthAppStatus {}

class LoginSuccessState extends AuthAppStatus {
  final String uid;
  LoginSuccessState(this.uid);
}

class LoginErrorState extends AuthAppStatus {
  final error;
  LoginErrorState(this.error);
}

class LoginLoadingState extends AuthAppStatus {}

class CreateUserSuccessState extends AuthAppStatus {}

class CreateUserErrorState extends AuthAppStatus {}
