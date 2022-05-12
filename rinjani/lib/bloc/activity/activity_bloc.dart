import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_source/repository/visit_repository.dart';
import 'activity_state.dart';
import 'activity_event.dart';
import 'activity_bloc.dart';

export 'activity_state.dart';
export 'activity_event.dart';
export 'activity_bloc.dart';

class ActivityBloc extends Bloc<ActivityBlocEvent, ActivityBlocState> {
  final VisitRepository _visitRepository;

  static create(VisitRepository visitRepository) => ActivityBloc._(visitRepository);

  ActivityBloc._(this._visitRepository);

  @override
  ActivityBlocState get initialState => InitialActivityBlocState();

  @override
  Stream<ActivityBlocState> mapEventToState(ActivityBlocEvent event) async* {
    if(event is GetActivityEvent) {
      yield* _mapGetActivityState(event);
    }
  }

  Stream<ActivityBlocState> _mapGetActivityState(GetActivityEvent e) async* {
    yield LoadingActivityState();
    final response = await _visitRepository.getActivity(e.branchId);
    if (response.message == "ok"){
      yield GetActivityState(response.activity);
    } else {
      yield FailedActivityState();
    }
  }
}