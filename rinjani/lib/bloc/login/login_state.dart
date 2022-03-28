import 'package:meta/meta.dart';
import 'package:rinjani/models/user.dart';

import '../../models/login.dart';


@immutable
abstract class LoginBlocState {}

class InitialLoginBlocState extends LoginBlocState {}

class LoadingLoginState extends LoginBlocState{}

class SuccesssLoginState extends LoginBlocState{}

class FailedLoginState extends LoginBlocState{}

class NotLoggedinState extends LoginBlocState{}

class ServerErrorState extends LoginBlocState{}
