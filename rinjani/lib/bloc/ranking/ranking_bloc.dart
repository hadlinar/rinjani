import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_source/repository/ranking_repository.dart';
import 'ranking_bloc.dart';

export 'ranking_state.dart';
export 'ranking_event.dart';
export 'ranking_bloc.dart';

class RankingBloc extends Bloc<RankingBlocEvent, RankingBlocState> {
  final RankingRepository _rankingRepository;

  static create(RankingRepository rankingRepository) => RankingBloc._(rankingRepository);

  RankingBloc._(this._rankingRepository);

  @override
  RankingBlocState get initialState => InitialRankingBlocState();

  @override
  Stream<RankingBlocState> mapEventToState(RankingBlocEvent event) async* {
    if(event is GetRankingEvent) {
      yield* _mapGetRankingToState(event);
    }
  }



  Stream<RankingBlocState> _mapGetRankingToState(GetRankingEvent e) async* {
    yield LoadingRankingState();
      final response = await _rankingRepository.getRanking();
      if (response.message == "ok") {
        yield GetRankingState(response.result);
      }
  }
}