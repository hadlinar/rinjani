import 'package:meta/meta.dart';



@immutable
abstract class LoginBlocState {}

class InitialLoginBlocState extends LoginBlocState {}

class LoadingLoginState extends LoginBlocState{}

class SuccesssLoginState extends LoginBlocState{}

class WrongPasswordLoginState extends LoginBlocState{}

class NotLoggedinState extends LoginBlocState{}

class ServerErrorState extends LoginBlocState{}
