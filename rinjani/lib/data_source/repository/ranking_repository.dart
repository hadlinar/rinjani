import 'package:rinjani/models/ranking.dart';

import '../network/ranking_service.dart';

class RankingRepository {
  final RankingService rankingService;

  RankingRepository(this.rankingService);

  Future<RankingResponse> getRanking() async {
    final response = await rankingService.getRanking();
    return response;
  }
}