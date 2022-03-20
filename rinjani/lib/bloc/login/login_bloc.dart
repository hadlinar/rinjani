import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rinjani/data_source/repository/login_user_repository.dart';
import 'package:rinjani/data_source/repository/user_repository.dart';

import 'login_state.dart';
import 'login_event.dart';
import 'login_bloc.dart';

export 'login_state.dart';
export 'login_event.dart';
export 'login_bloc.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  final UserRepository _userRepository;

  static create(UserRepository userRepository) => LoginBloc._(userRepository);

  LoginBloc._(this._userRepository);

  @override
  LoginBlocState get initialState => InitialLoginBlocState();

  @override
  Stream<LoginBlocState> mapEventToState(LoginBlocEvent event) async* {

    if(event is LoginUserEvent) {
      yield* _loginToState(event);
    }

  }

  Stream<LoginBlocState> _loginToState(LoginUserEvent e) async* {
    yield LoadingLoginState();
    print("cek event ${e.nik} ${e.password}");
    try {
      final response = await _userRepository.login(
        userId: e.nik,
        password: e.password
      );
      if(response.message == "ok") {
        final storage = new FlutterSecureStorage();
        await storage.write(key: "access_token", value: response.token);
        print(response.token);
        yield LoginSuccessState(response.result);
      }
    } on DioError catch (e) {
      if(e.response?.statusCode == 400){
        yield NotLoggedinState();
      }
        print("aaa ${e}");
        yield FailedLoginState();
      }
    }

}