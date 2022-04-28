import 'package:alice/alice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rinjani/bloc/branch/branch_bloc.dart';
import 'package:rinjani/bloc/customer/customer_bloc.dart';
import 'package:rinjani/bloc/launcher/launcher_bloc.dart';
import 'package:rinjani/bloc/login/login_bloc.dart';
import 'package:rinjani/bloc/role/role_bloc.dart';
import 'package:rinjani/bloc/visit/visit_bloc.dart';
import 'package:rinjani/data_source/network/customer_service.dart';
import 'package:rinjani/data_source/network/login_service.dart';
import 'package:rinjani/data_source/network/role_service.dart';
import 'package:rinjani/data_source/network/visit_service.dart';
import 'package:rinjani/data_source/repository/customer_repository.dart';
import 'package:dio/dio.dart';
import 'package:rinjani/data_source/repository/visit_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/employee/employee_bloc.dart';
import 'bloc/user/user_bloc.dart';
import 'data_source/network/branch_service.dart';
import 'data_source/network/employee_service.dart';
import 'data_source/network/user_service.dart';
import 'data_source/repository/branch_repository.dart';
import 'data_source/repository/employee_repository.dart';
import 'data_source/repository/login_repository.dart';
import 'data_source/repository/role_repository.dart';
import 'data_source/repository/user_repository.dart';

class AppModule {

  final String? base_url;

  AppModule(this.base_url);

  static final GetIt injector = GetIt.instance;

  Future<void> configureOthers() async {
    final dio = Dio();
    injector.registerSingleton(dio);
    injector.registerSingleton(await SharedPreferences.getInstance());
  }

  void configureService() {
    injector.registerSingleton<LoginService>(
        LoginService.create(injector.get())
    );
    injector.registerSingleton<CustomerService>(
        CustomerService.create(injector.get())
    );
    injector.registerSingleton<VisitService>(
        VisitService.create(injector.get())
    );
    injector.registerSingleton<BranchService>(
        BranchService.create(injector.get())
    );
    injector.registerSingleton<EmployeeService>(
        EmployeeService.create(injector.get())
    );
    injector.registerSingleton<UserService>(
        UserService.create(injector.get())
    );
    injector.registerSingleton<RoleService>(
        RoleService.create(injector.get())
    );
  }

  void configureRepository() {
    injector.registerSingleton(CustomerRepository(injector.get()));
    injector.registerSingleton(VisitRepository(injector.get()));
    injector.registerSingleton(BranchRepository(injector.get()));
    injector.registerSingleton(UserRepository(injector.get()));
    injector.registerSingleton(EmployeeRepository(injector.get()));
    injector.registerSingleton(LoginRepository(injector.get()));
    injector.registerSingleton(RoleRepository(injector.get()));
  }

  Widget configureBloc(Widget app) {
    return MultiBlocProvider(providers: [
      BlocProvider<LauncherBloc>(
        create: (_) => LauncherBloc.create(injector.get()),
      ),
      BlocProvider<CustomerBloc>(
        create: (_) => CustomerBloc.create(injector.get()),
      ),
      BlocProvider<VisitBloc>(
        create: (_) => VisitBloc.create(injector.get(), injector.get()),
      ),
      BlocProvider<BranchBloc>(
        create: (_) => BranchBloc.create(injector.get()),
      ),
      BlocProvider<EmployeeBloc>(
        create: (_) => EmployeeBloc.create(injector.get()),
      ),
      BlocProvider<UserBloc>(
        create: (_) => UserBloc.create(injector.get(), injector.get(), injector.get()),
      ),
      BlocProvider<LoginBloc>(
        create: (_) => LoginBloc.create(injector.get()),
      ),
      BlocProvider<RoleBloc>(
        create: (_) => RoleBloc.create(injector.get()),
      ),
    ], child: app);
  }

  Future<void> setup() async {
    await configureOthers();
    configureService();
    configureRepository();
    print("configure");
  }

}
