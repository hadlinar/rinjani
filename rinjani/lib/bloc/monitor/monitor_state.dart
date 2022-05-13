import 'package:meta/meta.dart';
import 'package:rinjani/models/monitor.dart';

@immutable
abstract class MonitorBlocState {}

class InitialMonitorBlocState extends MonitorBlocState {}

class LoadingMonitorState extends MonitorBlocState{}

class SuccessMonitorState extends MonitorBlocState{}

class FailedMonitorState extends MonitorBlocState{}

class GetMonitorState extends MonitorBlocState{
  List<Monitor> getMonitor;

  GetMonitorState(this.getMonitor);
}
