import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

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

  static create(VisitRepository visitRepository, SharedPreferences sharedPreferences) => VisitBloc._(visitRepository, sharedPreferences);

  VisitBloc._(this._visitRepository, this._sharedPreferences);

  @override
  VisitBlocState get initialState => InitialVisitBlocState();

  @override
  Stream<VisitBlocState> mapEventToState(VisitBlocEvent event) async* {
    if(event is GetVisitCategoryEvent) {
      yield* _mapVisitCategoryToState(event);
    }
    if(event is GetAllVisitEvent) {
      yield* _mapAllVisitToState(event);
    }
    if(event is GetRealizationEvent) {
      yield* _mapRealizationToState(event);
    }
    if(event is GetVisitEvent) {
      yield* _mapVisitToState(event);
    }
    if(event is GetVisitForRealizationEvent) {
      yield* _mapVisitForRealizationToState(event);
    }
    if(event is AddVisitEvent) {
      yield* _mapAddVisitToState(event);
    }
    if(event is AddRealizationEvent) {
      yield* _mapAddRealizationToState(event);
    }
    if(event is GetRealizationOpEvent) {
      yield* _mapRealizationOpToState(event);
    }
    if(event is DeleteVisitEvent) {
      yield* _mapDeleteVisitToState(event);
    }
    if(event is GetPDFEvent) {
      yield* _mapGetPDFToState(event);
    }
  }

  Stream<VisitBlocState> _mapVisitCategoryToState(GetVisitCategoryEvent event) async* {
    yield LoadingVisitState();
    final response = await _visitRepository.getVisitCategory();
    yield VisitCategoryList(response.result);
  }

  Stream<VisitBlocState> _mapAllVisitToState(GetAllVisitEvent event) async* {
    yield LoadingVisitState();
    final response = await _visitRepository.getAllVisit();
    yield GetVisitState(response.result);
  }

  Stream<VisitBlocState> _mapVisitToState(GetVisitEvent event) async* {
    yield LoadingVisitState();
    final token = _sharedPreferences.getString("access_token");
    try{
      final response = await _visitRepository.getVisit("Bearer $token");
      if (response.message == "ok") {
        yield GetVisitState(response.result);
      }
    } on DioError catch(e) {
      if(e.response?.statusCode == 500) {
        yield NotLogginInState();
      }
      else {
        yield FailedVisitState();
      }
    }
  }

  Stream<VisitBlocState> _mapVisitForRealizationToState(GetVisitForRealizationEvent event) async* {
    yield LoadingVisitState();
    final token = _sharedPreferences.getString("access_token");
    try{
      final response = await _visitRepository.getVisitForRealization("Bearer $token");
      if (response.message == "ok") {
        yield GetVisitState(response.result);
      }
    } on DioError catch(e) {
      print(e.message);
      if(e.response?.statusCode == 500) {
        yield NotLogginInState();
      }
      else {

        yield FailedVisitState();
      }
    }
  }

  Stream<VisitBlocState> _mapRealizationToState(GetRealizationEvent e) async* {
    yield LoadingVisitState();
    final token = _sharedPreferences.getString("access_token");
    try{
      final response = await _visitRepository.getRealization("Bearer $token", e.filter);
      if (response.message == "ok") {
        yield GetRealizationState(response.result);
      }
    } on DioError catch(e) {
      if(e.response?.statusCode == 500) {
        yield NotLogginInState();
      }
      else {
        yield FailedVisitState();
      }
    }
  }

  Stream<VisitBlocState> _mapAddVisitToState(AddVisitEvent e) async* {
    yield LoadingVisitState();
    final token = _sharedPreferences.getString("access_token");
    try {
      final response = await _visitRepository.postVisit(
          visit_id: e.visit_id,
          branch_id: e.branch_id,
          cust_id: e.cust_id,
          time_start: e.time_start,
          time_finish: e.time_finish,
          description: e.description,
          pic_position: e.pic_position,
          pic_name: e.pic_name,
          status_visit:e.status_visit,
          token: "Bearer $token"
      );
      if (response.message == "posted"){
        yield SuccessAddVisitState();
      }
    } on DioError catch(e) {
      if(e.response?.statusCode == 500) {
        yield NotLogginInState();
      }
      else {
        yield FailedVisitState();
      }
    }
  }

  Stream<VisitBlocState> _mapAddRealizationToState(AddRealizationEvent e) async* {
    yield LoadingVisitState();
    final token = _sharedPreferences.getString("access_token");
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
          description_real: e.description_real,
          token: "Bearer $token"
      );
      if (response.message == "posted"){
        yield SuccessAddRealizationState();
      }
    } on DioError catch(e) {
      if(e.response?.statusCode == 500) {
        yield NotLogginInState();
      }
      else {
        yield FailedVisitState();
      }
    }
  }

  Stream<VisitBlocState> _mapRealizationOpToState(GetRealizationOpEvent e) async* {
    print("id: ${e.id}, filter: ${e.filter}");
    yield LoadingVisitState();
    final response = await _visitRepository.getRealizationOp(e.id, e.filter);
    yield GetRealizationOpState(response.result);
  }

  Stream<VisitBlocState> _mapDeleteVisitToState(DeleteVisitEvent e) async* {
    yield LoadingVisitState();
    final token = _sharedPreferences.getString("access_token");
    try{
      final response = await _visitRepository.deleteVisit("Bearer $token", e.visitNo);
      if (response.message == "deleted") {
        yield SuccessDeleteVisitState();
      }
    } on DioError catch(e) {
      if(e.response?.statusCode == 500) {
        yield NotLogginInState();
      }
      else {
        yield FailedVisitState();
      }
    }
  }

  Stream<VisitBlocState> _mapGetPDFToState(GetPDFEvent e) async* {
    yield LoadingVisitState();
    final token = _sharedPreferences.getString("access_token");
    try{
      final response = await _visitRepository.getPDF("Bearer $token", e.startDate, e.endDate);
      if (response.message == "ok") {
        yield GetPDFState(response.result);
      }
    } on DioError catch(e) {
      if(e.response?.statusCode == 500) {
        yield NotLogginInState();
      }
      else {
        yield FailedVisitState();
      }
    }
  }
}