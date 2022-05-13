import 'package:meta/meta.dart';

import '../../models/pdf.dart';
import '../../models/visit.dart';

@immutable
abstract class VisitBlocState {}

class InitialVisitBlocState extends VisitBlocState {}

class LoadingVisitState extends VisitBlocState{}

class SuccesssVisitState extends VisitBlocState{}

class FailedVisitState extends VisitBlocState{}

class FailedAddCustVisitState extends VisitBlocState{}

class VisitCategoryList extends VisitBlocState{
  List<VisitCategory> getVisitCategory;

  VisitCategoryList(this.getVisitCategory);
}

class GetVisitState extends VisitBlocState{
  List<Visit> getVisit;

  GetVisitState(this.getVisit);
}

class GetRealizationState extends VisitBlocState{
  List<Realization> getRealization;

  GetRealizationState(this.getRealization);
}

class GetRealizationOpState extends VisitBlocState{
  List<Realization> getRealizationOp;

  GetRealizationOpState(this.getRealizationOp);
}

class SuccessAddVisitState extends VisitBlocState{}

class SuccessAddRealizationState extends VisitBlocState{}

class NotLogginInState extends VisitBlocState{}

class SuccessDeleteVisitState extends VisitBlocState{}

class GetPDFState extends VisitBlocState{
  List<PDF> getPDF;

  GetPDFState(this.getPDF);
}

// class GetRankingHighState extends VisitBlocState{
//   Ranking getRanking;
//
//   GetRankingHighState(this.getRanking);
// }
//
// class GetRankingLowState extends VisitBlocState{
//   Ranking getRanking;
//
//   GetRankingLowState(this.getRanking);
// }
