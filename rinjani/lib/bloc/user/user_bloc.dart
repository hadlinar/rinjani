import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data_source/repository/login_repository.dart';
import '../../data_source/repository/user_repository.dart';

import 'user_bloc.dart';

export 'user_state.dart';
export 'user_event.dart';
export 'user_bloc.dart';

class UserBloc extends Bloc<UserBlocEvent, UserBlocState> {
  final UserRepository _userRepository;
  final LoginRepository _loginRepository;
  final SharedPreferences _sharedPreferences;

  static create(UserRepository userRepository, LoginRepository loginRepository, SharedPreferences sharedPreferences) => UserBloc._(userRepository, loginRepository, sharedPreferences);

  UserBloc._(this._userRepository, this._loginRepository, this._sharedPreferences);

  @override
  UserBlocState get initialState => InitialUserBlocState();

  @override
  Stream<UserBlocState> mapEventToState(UserBlocEvent event) async* {
    if(event is GetUserEvent) {
      yield* _mapUserToState(event);
    }
    if(event is GetAllUserEvent) {
      yield* _mapAllUserToState(event);
    }
    if(event is LogoutEvent) {
      yield* _logoutToState(event);
    }
  }

  Stream<UserBlocState> _mapAllUserToState(GetAllUserEvent e) async* {
    yield LoadingUserState();
    final response = await _userRepository.getAllUser();
    yield GetAllUserState(response.result);
  }


  Stream<UserBlocState> _mapUserToState(GetUserEvent e) async* {
    yield LoadingUserState();
    final token = _sharedPreferences.getString("access_token");
    try{
      final response = await _userRepository.getUser("Bearer $token");
      if (response.message == "ok") {
        yield GetUserState(response.result);
      }

    } on DioError catch(e) {
      if(e.response?.statusCode == 403) {
        yield NotLoggedinState();
      }
      else {
        yield FailedUserState();
      }
    }
  }

  Stream<UserBlocState> _logoutToState(LogoutEvent e) async* {
    yield LoadingUserState();
    final token = _sharedPreferences.getString("access_token");
    try {
      final response = await _loginRepository.logout("Bearer $token");
      if(response.message == "Log out") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove("access_token");
        yield NotLoggedinState();
      }
    } on DioError catch (e) {
      if(e.response?.statusCode == 400){
        yield NotLoggedinState();
      }
      yield FailedUserState();
    }
  }
}