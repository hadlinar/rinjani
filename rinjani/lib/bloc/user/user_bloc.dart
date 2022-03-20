import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data_source/repository/user_repository.dart';

import 'user_state.dart';
import 'user_event.dart';
import 'user_bloc.dart';

export 'user_state.dart';
export 'user_event.dart';
export 'user_bloc.dart';

class UserBloc extends Bloc<UserBlocEvent, UserBlocState> {
  final UserRepository _userRepository;
  // final SharedPreferences _sharedPreferences;

  static create(UserRepository userRepository) => UserBloc._(userRepository);
  // static create(SharedPreferences sharedPreferences, UserRepository userRepository) => UserBloc._(sharedPreferences, userRepository);

  UserBloc._(this._userRepository);

  @override
  UserBlocState get initialState => InitialUserBlocState();

  @override
  Stream<UserBlocState> mapEventToState(UserBlocEvent event) async* {
    if(event is GetUserEvent) {
      yield* _mapUserToState(event);
    }
    if(event is LoginUserEvent) {
      yield* _mapLoginToState(event);
    }
    if(event is LoginEvent) {
      yield* _loginToState(event);
    }
    // if(event is LoginTokenEvent) {
    //   yield* _getUserToken(event);
    // }
  }

  Stream<UserBlocState> _mapUserToState(GetUserEvent e) async* {
    yield LoadingUserState();
    final response = await _userRepository.getUser(e.id);
    yield UserList(response.result);
  }

  // Stream<UserBlocState> _getUserToken(LoginTokenEvent event) async* {
  //   yield LoadingUserState();
  //   var isLogin = await Global.isLoggedIn();
  //   if (isLogin) {
  //     final token = _sharedPreferences.getString("access_token");
  //     try {
  //       final response = await _userRepository.getUserToken(token: "Bearer $token");
  //       if (response.message == "ok") {
  //         UserToken user = response.result;
  //         yield SuccessProfileState(user);
  //       }
  //     } on DioError catch (e) {
  //       if(e.response?.statusCode == 401) {
  //         yield NotLoggedinState();
  //       }
  //       else {
  //         yield FailedUserState();
  //       }
  //     }
  //   } else {
  //     yield NotLoggedinState();
  //   }
  // }


  Stream<UserBlocState> _mapLoginToState(LoginUserEvent e) async* {
    yield LoadingUserState();
    final response = await _userRepository.getAllUser();
    yield UserList(response.result);
  }

  Stream<UserBlocState> _loginToState(LoginEvent e) async* {
    yield LoadingUserState();
    try {
      final response = await _userRepository.login(
          userId: e.nik,
          password: e.password
      );
      if (response.message == "ok"){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        const storage = FlutterSecureStorage();
        await storage.write(key: "access_token", value: response.token);
        yield SuccessProfileState(response.result);
      }
    } on DioError catch(e) {
      if(e.response?.statusCode == 400) {
        yield FailedLoginState();
      } else if (e.response?.statusCode == 500) {
        yield ServerErrorState();
      } else {
        yield FailedUserState();
      }
    }
  }
}