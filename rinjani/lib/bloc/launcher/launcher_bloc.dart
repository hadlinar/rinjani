import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
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
      on DioError {
        _sharedPreferences.clear();
        yield NotLoggedinState();
      }
    }

  }

}