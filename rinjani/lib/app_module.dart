import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rinjani/bloc/branch/branch_bloc.dart';
import 'package:rinjani/bloc/customer/customer_bloc.dart';
import 'package:rinjani/bloc/visit/visit_bloc.dart';
import 'package:rinjani/data_source/network/customer_service.dart';
import 'package:rinjani/data_source/network/visit_service.dart';
import 'package:rinjani/data_source/repository/customer_repository.dart';
import 'package:dio/dio.dart';
import 'package:rinjani/data_source/repository/visit_repository.dart';

import 'bloc/employee/employee_bloc.dart';
import 'bloc/user/user_bloc.dart';
import 'data_source/network/branch_service.dart';
import 'data_source/network/employee_service.dart';
import 'data_source/network/user_service.dart';
import 'data_source/repository/branch_repository.dart';
import 'data_source/repository/employee_repository.dart';
import 'data_source/repository/user_repository.dart';

class AppModule {
  final String base_url;

  AppModule(this.base_url);

  final GetIt injector = GetIt.instance;

  void configureService() {
    injector.registerSingleton(Dio());
    injector.registerSingleton<CustomerService>(
        CustomerService.create(injector.get(), baseUrl: base_url)
    );
    injector.registerSingleton<VisitService>(
        VisitService.create(injector.get(), baseUrl: base_url)
    );
    injector.registerSingleton<BranchService>(
        BranchService.create(injector.get(), baseUrl: base_url)
    );
    injector.registerSingleton<EmployeeService>(
        EmployeeService.create(injector.get(), baseUrl: base_url)
    );
    injector.registerSingleton<UserService>(
        UserService.create(injector.get(), baseUrl: base_url)
    );
  }

  void configureRepository() {
    injector.registerSingleton(CustomerRepository(injector.get()));
    injector.registerSingleton(VisitRepository(injector.get()));
    injector.registerSingleton(BranchRepository(injector.get()));
    injector.registerSingleton(EmployeeRepository(injector.get()));
    injector.registerSingleton(UserRepository(injector.get()));
  }

  Widget configureBloc(Widget app) {
    return MultiBlocProvider(providers: [
      BlocProvider<CustomerBloc>(
        create: (_) => CustomerBloc.create(injector.get()),
      ),
      BlocProvider<VisitBloc>(
        create: (_) => VisitBloc.create(injector.get()),
      ),
      BlocProvider<BranchBloc>(
        create: (_) => BranchBloc.create(injector.get()),
      ),
      BlocProvider<EmployeeBloc>(
        create: (_) => EmployeeBloc.create(injector.get()),
      ),
      BlocProvider<UserBloc>(
        create: (_) => UserBloc.create(injector.get()),
      ),
    ], child: app);
  }

  void setup() {
    configureService();
    configureRepository();
    print("configure");
  }


}
