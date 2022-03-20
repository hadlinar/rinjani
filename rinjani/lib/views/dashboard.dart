import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rinjani/bloc/user/user_bloc.dart';
import 'package:rinjani/utils/global.dart';
import 'package:rinjani/views/page/realization.dart';
import 'package:rinjani/views/page/report.dart';
import 'package:rinjani/views/page/report.dart';

import '../models/user.dart';
import '../utils/global_state.dart';
import '../widget/calendar.dart';
// import 'package:rinjani/widget/calendar_1.dart';

// import '../widget/calendar_2.dart';

class Dashboard extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _Dashboard();
  }
}

final GlobalState store = GlobalState.instance;

class _Dashboard extends State<Dashboard> {
  late UserToken user;
  @override
  void initState() {
    user = store.get("login");
    super.initState();
    BlocProvider.of<UserBloc>(context).add(GetUserEvent(store.get("nik")));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserBlocState>(
      builder: (context, state) {
        if(state is UserList) {
          return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              body: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFF3FCFF),
                        Color(0xFF32BFFC),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                    )
                ),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 52, left: 22, right: 22),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              user.name,
                              style: Global.getCustomFont(Global.BLACK, 22, 'bold')
                          ),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 12, left: 22, right: 22, bottom: 32),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              user.nik,
                              style: Global.getCustomFont(Global.BLACK, 22, 'book')
                          ),
                        )
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white,
                                  Colors.white,
                                ]
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)
                            )
                        ),
                        child: Container(
                          padding: EdgeInsets.only(top: 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              store.get("role_id") != "3" ?
                              Column(
                                children: <Widget>[
                                  GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => Calendar()
                                        ));
                                      },
                                      child: Global.getMenuCard("planning.png", 0xffE1BBBB)
                                  ),
                                  Global.getMenuText("Planning")
                                ],
                              ) : Container(),
                              store.get("role_id") != "3" ? Column(
                                children: <Widget>[
                                  GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => Realization()
                                        ));
                                      },
                                      child: Global.getMenuCard("realization.png", 0xffDAC2ED)
                                  ),
                                  Global.getMenuText("Realization")
                                ],
                              ) : Container(),
                              Column(
                                children: <Widget>[
                                  GestureDetector(
                                      onTap: (){
                                        print("test");
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => Report()
                                        ));
                                      },
                                      child: Global.getMenuCard("report.png", 0xffF2EFA7)
                                  ),
                                  Global.getMenuText("Report")
                                ],
                              )
                            ],
                          ),
                        )
                    ),
                  ],
                ),
              )
          );
        } else {
          return Container();
        }
      },
    );
  }
}