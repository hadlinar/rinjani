import '../../models/branch.dart';
import '../network/branch_service.dart';

class BranchRepository {
  final BranchService branchService;

  BranchRepository(this.branchService);

  Future<BranchResponse> getBranch() async {
    final response = await branchService.getBranch();
    return response;
  }

}