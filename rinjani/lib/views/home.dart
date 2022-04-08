import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:rinjani/views/login.dart';

import '../bloc/launcher/launcher_bloc.dart';
import '../utils/global.dart';
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
              if (state is LoggedInState) {
                SplashScreen(
                    seconds: 8,
                    navigateAfterSeconds: Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Dashboard()
                    )),
                    image: Image.asset(Global.LOGO_ICON),
                    photoSize: 100.0,
                    backgroundColor: Colors.white,
                    loaderColor: Colors.blue
                );
              }
              if (state is NotLoggedinState) {
                SplashScreen(
                    seconds: 8,
                    navigateAfterSeconds: Navigator.push(context, MaterialPageRoute(
                        builder: (context) => LoginPage()
                    )),
                    image: Image.asset(Global.LOGO_ICON),
                    photoSize: 100.0,
                    backgroundColor: Colors.white,
                    loaderColor: Colors.blue
                );
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
