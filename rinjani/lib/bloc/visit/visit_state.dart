import 'package:meta/meta.dart';

import '../../models/visit.dart';

@immutable
abstract class VisitBlocState {}

class InitialVisitBlocState extends VisitBlocState {}

class LoadingVisitState extends VisitBlocState{}

class SuccesssVisitState extends VisitBlocState{}

class FailedVisitState extends VisitBlocState{}

class VisitCategoryList extends VisitBlocState{
  List<VisitCategory> getVisitCategory;

  VisitCategoryList(this.getVisitCategory);
}

class VisitList extends VisitBlocState{
  List<Visit> getVisit;

  VisitList(this.getVisit);
}

class VisitRealizationList extends VisitBlocState{
  List<VisitReal> getVisitRealization;

  VisitRealizationList(this.getVisitRealization);
}

class VisitByIdList extends VisitBlocState{
  List<VisitById> getVisit;

  VisitByIdList(this.getVisit);
}

class VisitRealizationByIdList extends VisitBlocState{
  List<VisitRealById> getVisitRealization;

  VisitRealizationByIdList(this.getVisitRealization);
}

class SuccessAddVisitState extends VisitBlocState{}

class SuccessAddRealizationState extends VisitBlocState{}

