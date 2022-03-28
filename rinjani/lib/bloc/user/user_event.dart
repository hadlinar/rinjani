import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserBlocEvent{}

class GetUserEvent extends UserBlocEvent{}

class GetAllUserEvent extends UserBlocEvent{}

class LogoutEvent extends UserBlocEvent{}
