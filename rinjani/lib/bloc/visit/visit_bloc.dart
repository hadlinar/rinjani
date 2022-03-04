import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_source/repository/visit_repository.dart';
import 'visit_state.dart';
import 'visit_event.dart';
import 'visit_bloc.dart';

export 'visit_state.dart';
export 'visit_event.dart';
export 'visit_bloc.dart';

class VisitBloc extends Bloc<VisitBlocEvent, VisitBlocState> {
  final VisitRepository _visitRepository;

  static create(VisitRepository visitRepository) => VisitBloc._(visitRepository);

  VisitBloc._(this._visitRepository);

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
    if(event is AddVisitEvent) {
      yield* _mapAddVisitToState(event);
    }
    if(event is AddRealizationEvent) {
      yield* _mapAddRealizationToState(event);
    }
  }

  Stream<VisitBlocState> _mapVisitCategoryToState(GetVisitCategoryEvent event) async* {
    yield LoadingVisitState();
    final response = await _visitRepository.getVisitCategory();
    yield VisitCategoryList(response.result);
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
          visit_cat: e.visit_cat,
          branch_id: e.branch_id,
          cust_id: e.cust_id,
          time_start: e.time_start,
          time_finish: e.time_finish,
          user_id: e.user_id,
          description: e.description,
          pic_position: e.pic_position,
          pic_name: e.pic_name,
          status_visit:e.status_visit
      );
      if (response.message == "ok"){
        yield SuccessAddVisitState();
      }
    }
    catch(e) {
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
          user_id: e.user_id,
          description: e.description,
          pic_position: e.pic_position,
          pic_name: e.pic_name,
          status_visit: e.status_visit,
          latitude: e.latitude,
          longitude: e.longitude
      );
      if (response.message == "ok"){
        yield SuccessAddRealizationState();
      }
    }
    catch(e) {
      yield FailedVisitState();
    }
  }
}