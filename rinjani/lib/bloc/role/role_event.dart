import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RoleBlocEvent{}

class GetRoleEvent extends RoleBlocEvent{}