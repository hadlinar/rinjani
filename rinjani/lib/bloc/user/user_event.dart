import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserBlocEvent{}

class GetUserEvent extends UserBlocEvent{
  String id;

  GetUserEvent(this.id);
}

class LoginTokenEvent extends UserBlocEvent{
  final String? keyword;

  LoginTokenEvent({this.keyword});
}


class LoginUserEvent extends UserBlocEvent{}

class LoginEvent extends UserBlocEvent{
  final String nik;
  final String password;

  LoginEvent(
    this.nik,
    this.password
  );
}