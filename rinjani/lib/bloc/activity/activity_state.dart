import 'package:meta/meta.dart';

import '../../models/pdf.dart';
import '../../models/visit.dart';

@immutable
abstract class ActivityBlocState {}

class InitialActivityBlocState extends ActivityBlocState {}

class LoadingActivityState extends ActivityBlocState{}

class SuccessActivityState extends ActivityBlocState{}

class FailedActivityState extends ActivityBlocState{}

class GetActivityState extends ActivityBlocState{
  Activity getActivity;

  GetActivityState(this.getActivity);
}