import 'package:meta/meta.dart';
import 'package:rinjani/models/user.dart';

import '../../models/login_user.dart';


@immutable
abstract class LoginBlocState {}

class InitialLoginBlocState extends LoginBlocState {}

class LoadingLoginState extends LoginBlocState{}

// class SuccesssLoginState extends LoginBlocState{}

class FailedLoginState extends LoginBlocState{}

class LoginSuccessState extends LoginBlocState{
  UserToken login;

  LoginSuccessState(this.login);
}

class NotLoggedinState extends LoginBlocState{}

class ServerErrorState extends LoginBlocState{}
