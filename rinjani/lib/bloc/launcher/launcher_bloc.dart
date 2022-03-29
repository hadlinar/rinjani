import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rinjani/data_source/network/user_service.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'launcher_state.dart';
import 'launcher_event.dart';
import 'launcher_bloc.dart';

export 'launcher_state.dart';
export 'launcher_event.dart';
export 'launcher_bloc.dart';

class LauncherBloc extends Bloc<LauncherBlocEvent, LauncherBlocState> {
  final SharedPreferences _sharedPreferences;

  static create(SharedPreferences sharedPreferences) => LauncherBloc._(sharedPreferences);

  LauncherBloc._(this._sharedPreferences);

  @override
  LauncherBlocState get initialState => InitialLauncherState();

  Stream<LauncherBlocState> mapEventToState(
      LauncherBlocEvent event,
      ) async* {
    if(event is LaunchAppEvent) {
      yield* _mapEventToState();
    }
  }

  Stream<LauncherBlocState> _mapEventToState() async* {
    final token =  _sharedPreferences.getString("access_token");

    if(token == null) {
      yield NotLoggedinState();
    }
    else {
      try {
        yield LoggedInState();
      }
      on DioError catch(e) {
        print(e.response);
        _sharedPreferences.clear();
        yield NotLoggedinState();
      }
    }

  }

}