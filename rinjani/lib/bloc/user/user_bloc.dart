import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_source/repository/user_repository.dart';
import 'user_state.dart';
import 'user_event.dart';
import 'user_bloc.dart';

export 'user_state.dart';
export 'user_event.dart';
export 'user_bloc.dart';

class UserBloc extends Bloc<UserBlocEvent, UserBlocState> {
  final UserRepository _userRepository;

  static create(UserRepository userRepository) => UserBloc._(userRepository);

  UserBloc._(this._userRepository);

  @override
  UserBlocState get initialState => InitialUserBlocState();

  @override
  Stream<UserBlocState> mapEventToState(UserBlocEvent event) async* {
    if(event is GetUserEvent) {
      yield* _mapUserToState();
    }
  }

  Stream<UserBlocState> _mapUserToState() async* {
    yield LoadingUserState();
    final response = await _userRepository.getUser();
    yield UserList(response.result);
  }
}