import '../../models/role.dart';
import '../network/role_service.dart';

class RoleRepository {
  final RoleService roleService;

  RoleRepository(this.roleService);

  Future<RoleResponse> getRole() async {
    final response = await roleService.getRole();
    return response;
  }

}