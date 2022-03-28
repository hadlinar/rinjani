import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginBlocEvent{}

class LoginEvent extends LoginBlocEvent{
  final String nik;
  final String password;

  LoginEvent(
      this.nik,
      this.password
    );
}
