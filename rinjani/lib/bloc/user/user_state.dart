import 'package:meta/meta.dart';

// import '../../models/Login.dart';
import '../../models/user.dart';

@immutable
abstract class UserBlocState {}

class InitialUserBlocState extends UserBlocState {}

class LoadingUserState extends UserBlocState{}

class SuccesssUserState extends UserBlocState{}

class FailedUserState extends UserBlocState{}

class UserList extends UserBlocState{
  List<User> getUser;

  UserList(this.getUser);
}

// class LoginSuccessState extends UserBlocState{
//   LoginResult login;
//
//   LoginSuccessState(this.login);
// }

class SuccessProfileState extends UserBlocState{
  UserToken user;

  SuccessProfileState(this.user);
}

class FailedLoginState extends UserBlocState{}

class NotLoggedinState extends UserBlocState{}

class ServerErrorState extends UserBlocState{}
