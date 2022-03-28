import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rinjani/data_source/repository/login_repository.dart';
import 'package:rinjani/data_source/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_state.dart';
import 'login_event.dart';
import 'login_bloc.dart';

export 'login_state.dart';
export 'login_event.dart';
export 'login_bloc.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  final LoginRepository _loginRepository;

  static create(LoginRepository loginRepository) => LoginBloc._(loginRepository);

  LoginBloc._(this._loginRepository);

  @override
  LoginBlocState get initialState => InitialLoginBlocState();

  @override
  Stream<LoginBlocState> mapEventToState(LoginBlocEvent event) async* {
    if(event is LoginEvent) {
      yield* _loginToState(event);
    }

  }

  Stream<LoginBlocState> _loginToState(LoginEvent e) async* {
    yield LoadingLoginState();
    try {
      final response = await _loginRepository.login(
        nik: e.nik,
        password: e.password
      );
      if(response.message == "ok") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("access_token", response.token);
        yield SuccesssLoginState();
      }
    } on DioError catch (e) {
      print(e.message);
      if(e.response?.statusCode == 400){
        yield NotLoggedinState();
      }
        yield FailedLoginState();
      }
    }
}