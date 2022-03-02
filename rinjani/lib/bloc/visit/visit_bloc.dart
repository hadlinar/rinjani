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
      yield* _mapVisitCategoryToState();
    }
  }

  Stream<VisitBlocState> _mapVisitCategoryToState() async* {
    yield LoadingVisitState();
    final response = await _visitRepository.getVisitCategory();
    yield VisitCategoryList(response.result);
  }
}