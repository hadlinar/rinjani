import 'package:meta/meta.dart';

import '../../models/pdf.dart';
import '../../models/ranking.dart';

@immutable
abstract class RankingBlocState {}

class InitialRankingBlocState extends RankingBlocState {}

class LoadingRankingState extends RankingBlocState{}

class SuccessRankingState extends RankingBlocState{}

class FailedRankingState extends RankingBlocState{}

class GetRankingState extends RankingBlocState{
  List<Ranking> getRanking;

  GetRankingState(this.getRanking);
}
