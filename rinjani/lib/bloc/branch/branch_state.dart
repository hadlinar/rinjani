import 'package:meta/meta.dart';

import '../../models/branch.dart';

@immutable
abstract class BranchBlocState {}

class InitialBranchBlocState extends BranchBlocState {}

class LoadingBranchState extends BranchBlocState{}

class SuccesssBranchState extends BranchBlocState{}

class FailedBranchState extends BranchBlocState{}

class BranchList extends BranchBlocState{
  List<Branch> getBranch;

  BranchList(this.getBranch);
}

class BranchOpList extends BranchBlocState{
  List<BranchOp> getBranchOp;

  BranchOpList(this.getBranchOp);
}
