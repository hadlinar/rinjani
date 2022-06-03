import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rinjani/bloc/user/user_bloc.dart';

import '../../utils/global.dart';
import '../bloc/login/login_bloc.dart';
import '../utils/global_state.dart';
import 'dashboard.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

final GlobalState store = GlobalState.instance;

class _LoginPage extends State<LoginPage> {
  TextEditingController nikController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String nik;
  late String pass;
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginBlocState>(
        listener: (context, state) {
          print(state.toString());
          if (state is SuccesssLoginState) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => Dashboard()
            ));
          }
          if (state is LoadingLoginState){
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    title: const SizedBox(
                      height: 50,
                      width: 50,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          child: Center(
                            child: Text("Please wait",
                                style: Global.getCustomFont(Global.GREY, 14, 'book'),
                                textAlign: TextAlign.center)
                          ),
                        ),
                      ],
                    ),
                  );
                }
              );
          }
          if (state is WrongPasswordLoginState) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Global.defaultModal(() {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }, context, Global.WARNING_ICON, "Wrong password", "Try again", false);
                }
            );
          }
          if (state is ServerErrorState) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Global.defaultModal(() {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }, context, Global.WARNING_ICON, "Internal Server Error", "Try again", false);
                }
            );
          }
          if (state is NotLoggedinState) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Global.defaultModal(() {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }, context, Global.WARNING_ICON, "NIK is not registered", "Try again", false);
                }
            );
          }
        },

        child: GestureDetector (
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
        },
          child:  Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                ),
                body: SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.only(left: 21, right: 21),
                      margin: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 239,
                            child: Image.asset(
                              'assets/images/logo.png',
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 30, bottom: 20),
                            child: TextFormField(
                              style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
                              maxLines: 1,
                              controller: nikController,
                              onChanged: (text) {
                                nik = text;
                              },
                              decoration: InputDecoration(
                                labelText: "NIK",
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius .circular(10),
                                    borderSide: const BorderSide()),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 32.0),
                            child: TextFormField(
                              controller: passwordController,
                              onChanged: (text) {
                                pass = text;
                              },
                              style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
                              obscureText: showPassword,
                              decoration: InputDecoration(
                                labelText: "Password",
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius .circular(10),
                                    borderSide: const BorderSide()
                                ),
                                suffixIcon: IconButton(
                                    icon: const Icon(Icons.remove_red_eye),
                                    onPressed: () {
                                      setState(() {
                                        showPassword = !showPassword;
                                      });
                                    }
                                )
                              ),
                            ),
                          ),
                          Stack(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 9),
                                  width: 150,
                                  height: 56,
                                  color: Colors.white,
                                  child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(color: Color(Global.BLUE)),
                                          borderRadius: BorderRadius.circular(30)
                                      ),
                                      color: Color(Global.BLUE),
                                      onPressed: () {
                                        BlocProvider.of<LoginBloc>(context).add(
                                            LoginEvent(
                                              nik,
                                              pass
                                            )
                                        );

                                      },
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'bold',
                                            fontSize: 15
                                        ),
                                      )
                                  ),
                                ),
                              ]
                          )
                        ] ,
                      )
                  ),
                )
            )
        )
    );
  }

  @override
  void dispose() {
    super.dispose();
    nikController.dispose();
    passwordController.dispose();
  }
}
