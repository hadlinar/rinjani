import 'package:meta/meta.dart';

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

