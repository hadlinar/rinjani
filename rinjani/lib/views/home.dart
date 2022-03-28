import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rinjani/views/login.dart';

import '../bloc/launcher/launcher_bloc.dart';
import 'dashboard.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {

  @override
  void initState(){
    super.initState();
    BlocProvider.of<LauncherBloc>(context).add(LaunchAppEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<LauncherBloc, LauncherBlocState>(
          listener: (context, state) {
            print(state.toString() + " launcher");
            if (state is LoggedInState) {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Dashboard()
              ));
            }
            else if (state is NotLoggedinState) {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => LoginPage()
              ));
            }
          },
          child: Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator())
          )
        )
    );
  }
}

