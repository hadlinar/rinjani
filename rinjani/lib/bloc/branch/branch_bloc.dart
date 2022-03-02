import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_source/repository/branch_repository.dart';
import 'branch_state.dart';
import 'branch_event.dart';
import 'branch_bloc.dart';

export 'branch_state.dart';
export 'branch_event.dart';
export 'branch_bloc.dart';

class BranchBloc extends Bloc<BranchBlocEvent, BranchBlocState> {
  final BranchRepository _branchRepository;

  static create(BranchRepository branchRepository) => BranchBloc._(branchRepository);

  BranchBloc._(this._branchRepository);

  @override
  BranchBlocState get initialState => InitialBranchBlocState();

  @override
  Stream<BranchBlocState> mapEventToState(BranchBlocEvent event) async* {
    if(event is GetBranchEvent) {
      yield* _mapBranchToState();
    }
  }

  Stream<BranchBlocState> _mapBranchToState() async* {
    yield LoadingBranchState();
    final response = await _branchRepository.getBranch();
    yield BranchList(response.result);
  }
}