import 'package:meta/meta.dart';

import '../../models/branch.dart';

@immutable
abstract class LauncherBlocState {}

class InitialLauncherState extends LauncherBlocState {}

class LoggedInState extends LauncherBlocState {}

class NotLoggedInState extends LauncherBlocState {}
