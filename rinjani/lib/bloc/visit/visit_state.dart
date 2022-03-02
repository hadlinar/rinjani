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

