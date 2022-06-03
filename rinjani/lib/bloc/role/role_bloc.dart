import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_source/repository/role_repository.dart';
import 'role_bloc.dart';

export 'role_state.dart';
export 'role_event.dart';
export 'role_bloc.dart';

class RoleBloc extends Bloc<RoleBlocEvent, RoleBlocState> {
  final RoleRepository _roleRepository;

  static create(RoleRepository roleRepository) => RoleBloc._(roleRepository);

  RoleBloc._(this._roleRepository);

  @override
  RoleBlocState get initialState => InitialRoleBlocState();

  @override
  Stream<RoleBlocState> mapEventToState(RoleBlocEvent event) async* {
    if(event is GetRoleEvent) {
      yield* _mapRoleToState();
    }
  }

  Stream<RoleBlocState> _mapRoleToState() async* {
    yield LoadingRoleState();
    final response = await _roleRepository.getRole();
    yield GetRoleState(response.result);
  }
}