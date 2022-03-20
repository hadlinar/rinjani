import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginBlocEvent{}

class LoginTokenEvent extends LoginBlocEvent{
  final String? keyword;

  LoginTokenEvent({this.keyword});
}


class LoginUserEvent extends LoginBlocEvent{
  final String nik;
  final String password;

  LoginUserEvent(
      this.nik,
      this.password
    );
}