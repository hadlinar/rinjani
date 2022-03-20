import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data_source/repository/visit_repository.dart';
import 'visit_state.dart';
import 'visit_event.dart';
import 'visit_bloc.dart';

export 'visit_state.dart';
export 'visit_event.dart';
export 'visit_bloc.dart';

class VisitBloc extends Bloc<VisitBlocEvent, VisitBlocState> {
  final VisitRepository _visitRepository;
  final SharedPreferences _sharedPreferences;

  static create(SharedPreferences sharedPreferences, VisitRepository visitRepository) => VisitBloc._(sharedPreferences, visitRepository);

  VisitBloc._(this._sharedPreferences, this._visitRepository);

  @override
  VisitBlocState get initialState => InitialVisitBlocState();

  @override
  Stream<VisitBlocState> mapEventToState(VisitBlocEvent event) async* {
    if(event is GetVisitCategoryEvent) {
      yield* _mapVisitCategoryToState(event);
    }
    if(event is GetVisitRealizationEvent) {
      yield* _mapVisitRealizationToState(event);
    }
    if(event is GetVisitEvent) {
      yield* _mapVisitToState(event);
    }
    if(event is AddVisitEvent) {
      yield* _mapAddVisitToState(event);
    }
    if(event is AddRealizationEvent) {
      yield* _mapAddRealizationToState(event);
    }
    if(event is GetVisitRealizationByIdEvent) {
      yield* _mapVisitRealizationByIdToState(event);
    }
    if(event is GetVisitByIdEvent) {
      yield* _mapVisitByIdToState(event);
    }
  }

  Stream<VisitBlocState> _mapVisitCategoryToState(GetVisitCategoryEvent event) async* {
    yield LoadingVisitState();
    final response = await _visitRepository.getVisitCategory();
    yield VisitCategoryList(response.result);
  }

  Stream<VisitBlocState> _mapVisitToState(GetVisitEvent event) async* {
    yield LoadingVisitState();
    final response = await _visitRepository.getVisit();
    yield VisitList(response.result);
  }

  Stream<VisitBlocState> _mapVisitRealizationToState(GetVisitRealizationEvent event) async* {
    yield LoadingVisitState();
    final response = await _visitRepository.getVisitRealization();
    yield VisitRealizationList(response.result);
  }

  Stream<VisitBlocState> _mapAddVisitToState(AddVisitEvent e) async* {
    yield LoadingVisitState();
    try {
      final response = await _visitRepository.postVisit(
          visit_id: e.visit_id,
          branch_id: e.branch_id,
          cust_id: e.cust_id,
          time_start: e.time_start,
          time_finish: e.time_finish,
          userId: e.user_id,
          description: e.description,
          pic_position: e.pic_position,
          pic_name: e.pic_name,
          status_visit:e.status_visit
      );
      if (response.message == "posted"){
        yield SuccessAddVisitState();
      }
    }
    catch(e) {
      print(e.toString());
      yield FailedVisitState();
    }
  }

  Stream<VisitBlocState> _mapAddRealizationToState(AddRealizationEvent e) async* {
    yield LoadingVisitState();
    try {
      final response = await _visitRepository.postRealization(
          visit_no: e.visit_no,
          branch_id: e.branch_id,
          cust_id: e.cust_id,
          time_start: e.time_start,
          time_finish: e.time_finish,
          description: e.description,
          pic_position: e.pic_position,
          pic_name: e.pic_name,
          status_visit: e.status_visit,
          latitude: e.latitude,
          longitude: e.longitude,
          userId: e.user_id
      );
      if (response.message == "posted"){
        print(response.message);
        yield SuccessAddRealizationState();
      }
    }
    catch(e) {
      print(e.toString());
      yield FailedVisitState();
    }
  }

  Stream<VisitBlocState> _mapVisitRealizationByIdToState(GetVisitRealizationByIdEvent event) async* {
    yield LoadingVisitState();
    final response = await _visitRepository.getVisitRealizationById(event.id);
    try {
      final token = _sharedPreferences.getString("access_token");
      final response = await _visitRepository.getVisitRealizationById(event.id);
      if(response.message == "ok") {
        yield VisitRealizationByIdList(response.result);
      }
    }
    catch (e) {
      yield FailedVisitState();
    }
  }

  Stream<VisitBlocState> _mapVisitByIdToState(GetVisitByIdEvent event) async* {
    yield LoadingVisitState();
    final response = await _visitRepository.getVisitById(event.id);
    yield VisitByIdList(response.result);
  }
}