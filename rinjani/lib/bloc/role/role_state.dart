import 'package:meta/meta.dart';

import '../../models/role.dart';

@immutable
abstract class RoleBlocState {}

class InitialRoleBlocState extends RoleBlocState {}

class LoadingRoleState extends RoleBlocState{}

class SuccesssRoleState extends RoleBlocState{}

class FailedRoleState extends RoleBlocState{}

class GetRoleState extends RoleBlocState{
  List<Role> getRole;

  GetRoleState(this.getRole);
}

