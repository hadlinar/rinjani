import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rinjani/bloc/user/user_bloc.dart';
import 'package:rinjani/models/monitor.dart';
import 'package:rinjani/utils/global.dart';
import 'package:rinjani/views/page/analyze.dart';
import 'package:rinjani/views/page/realization.dart';
import 'package:rinjani/views/page/report.dart';
import '../bloc/monitor/monitor_bloc.dart';
import '../bloc/ranking/ranking_bloc.dart';
import '../models/ranking.dart';
import '../utils/global_state.dart';
import '../widget/calendar.dart';
import 'login.dart';

class Dashboard extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _Dashboard();
  }
}

final GlobalState store = GlobalState.instance;

class _Dashboard extends State<Dashboard> {
  List<Ranking> ranking = [];
  List<Monitor> monitor = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(GetUserEvent());
    BlocProvider.of<RankingBloc>(context).add(GetRankingEvent());
    BlocProvider.of<MonitorBloc>(context).add(GetMonitorEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserBlocState>(
      builder: (context, state) {
        if(state is LoadingUserState || state is InitialUserBlocState) {
          return Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator()
            )
          );
        }
        if(state is GetUserState) {
          store.set("role_id", state.getUser.role_id);
          store.set("user_id", state.getUser.user_id);
          store.set("name", state.getUser.name);
          store.set("branch_id", state.getUser.branch_id);
          return WillPopScope(
            onWillPop: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Global.defaultModal(() {
                      Navigator.pop(context);
                      SystemNavigator.pop();
                    }, context, Global.WARNING_ICON, "Are you sure you want to quit Rinjani?", "Yes", true);
                  }
              );
              return Future.value(true);
            },
            child: Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                ),
                body: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF9FC4D4),
                          Color(0xFF0071A4),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                      )
                  ),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget> [
                          Container(
                            padding: const EdgeInsets.only(right: 22),
                            child: InkWell(
                              child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Global.defaultModal(() {
                                            Navigator.pop(context);
                                            store.set("role_id", "");
                                            store.set("user_id", "");
                                            store.set("name", "");
                                            store.set("branch_id", "");
                                            BlocProvider.of<UserBloc>(
                                                context)
                                                .add(LogoutEvent());
                                          }, context, Global.WARNING_ICON, "Are you sure you want to log out?", "Yes", true);
                                        }
                                    );
                                  },
                                  icon: ImageIcon(
                                    const AssetImage(Global.LOGOUT_ICON),
                                    color: Color(Global.WHITE),
                                    size: 28,
                                  )
                              ),
                            )
                          )
                        ]
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 21, left: 22, right: 22),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                state.getUser.name,
                                style: Global.getCustomFont(0xFFFFFFFF, 22, 'bold')
                            ),
                          )
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 12, left: 22, right: 22, bottom: 32),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                state.getUser.nik,
                                style: Global.getCustomFont(0xFFFFFFFF, 22, 'book')
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
                          child: state.getUser.role_id == "2" ? Container(
                            padding: const EdgeInsets.only(top: 32, left: 21),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                BlocListener<RankingBloc, RankingBlocState>(
                                  listener: (context, state) {
                                    if(state is GetRankingState) {
                                      setState(() {
                                        ranking = state.getRanking;
                                      });

                                    }
                                  },
                                  child: Container()
                                ),
                                BlocListener<MonitorBloc, MonitorBlocState>(
                                    listener: (context, state) {
                                      if(state is GetMonitorState) {
                                        setState(() {
                                          monitor = state.getMonitor;
                                        });

                                      }
                                    },
                                    child: Container()
                                ),
                                Column(
                                  children: <Widget>[
                                    GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => Report()
                                          ));
                                        },
                                        child: Global.getMenuCard("report.png", 0xffF2EFA7)
                                    ),
                                    Global.getMenuText("Report")
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 21),
                                  child: Column(
                                    children: <Widget>[
                                      GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => Analyze(ranking, monitor)
                                            ));
                                          },
                                          child: Global.getMenuCard("analyze.png", 0xffBEE1BB)
                                      ),
                                      Global.getMenuText("Analyze")
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ) :
                          Container(
                            padding: const EdgeInsets.only(top: 32),
                            margin: const EdgeInsets.only(right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                                BlocListener<RankingBloc, RankingBlocState>(
                                    listener: (context, state) {
                                      if(state is GetRankingState) {
                                        setState(() {
                                          ranking = state.getRanking;
                                        });

                                      }
                                    },
                                    child: Container()
                                ),
                                BlocListener<MonitorBloc, MonitorBlocState>(
                                    listener: (context, state) {
                                      if(state is GetMonitorState) {
                                        setState(() {
                                          monitor = state.getMonitor;
                                        });

                                      }
                                    },
                                    child: Container()
                                ),
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
                                ),
                                Column(
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
                                ),
                                Column(
                                  children: <Widget>[
                                    GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => Report()
                                          ));
                                        },
                                        child: Global.getMenuCard("report.png", 0xffF2EFA7)
                                    ),
                                    Global.getMenuText("Report")
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => Analyze(ranking, monitor)
                                          ));
                                        },
                                        child: Global.getMenuCard("analyze.png", 0xffBEE1BB)
                                    ),
                                    Global.getMenuText("Analyze")
                                  ],
                                ),
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                )
            ),
          );
        }
        if(state is FailedUserState || state is NotLoggedinState) {
          return LoginPage();
        } else {
          return Container();
        }
      },
    );
  }
}