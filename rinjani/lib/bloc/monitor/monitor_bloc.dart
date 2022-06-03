import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_source/repository/monitor_repository.dart';
import 'monitor_bloc.dart';

export 'monitor_state.dart';
export 'monitor_event.dart';
export 'monitor_bloc.dart';

class MonitorBloc extends Bloc<MonitorBlocEvent, MonitorBlocState> {
  final MonitorRepository _monitorRepository;

  static create(MonitorRepository monitorRepository) => MonitorBloc._(monitorRepository);

  MonitorBloc._(this._monitorRepository);

  @override
  MonitorBlocState get initialState => InitialMonitorBlocState();

  @override
  Stream<MonitorBlocState> mapEventToState(MonitorBlocEvent event) async* {
    if(event is GetMonitorEvent) {
      yield* _mapGetMonitorToState(event);
    }
  }



  Stream<MonitorBlocState> _mapGetMonitorToState(GetMonitorEvent e) async* {
    yield LoadingMonitorState();
      final response = await _monitorRepository.getMonitor();
      if (response.message == "ok") {
        yield GetMonitorState(response.result);
      }
  }
}