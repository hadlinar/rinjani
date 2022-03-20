import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LauncherBlocEvent{}

class LaunchAppEvent extends LauncherBlocEvent{}