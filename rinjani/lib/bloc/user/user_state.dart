import 'package:meta/meta.dart';

// import '../../models/Login.dart';
import '../../models/user.dart';

@immutable
abstract class UserBlocState {}

class InitialUserBlocState extends UserBlocState {}

class LoadingUserState extends UserBlocState{}

class SuccesssUserState extends UserBlocState{}

class FailedUserState extends UserBlocState{}

class GetAllUserState extends UserBlocState{
  List<User> getUser;

  GetAllUserState(this.getUser);
}

class GetUserState extends UserBlocState{
  User getUser;

  GetUserState(this.getUser);
}

class NotLoggedinState extends UserBlocState{}

class ServerErrorState extends UserBlocState{}
