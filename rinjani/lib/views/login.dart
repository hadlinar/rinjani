import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rinjani/bloc/user/user_bloc.dart';

import '../../utils/global.dart';
import '../bloc/login/login_bloc.dart';
import '../utils/global_state.dart';
import '../widget/custom_text_field.dart';
import 'dashboard.dart';
import 'home.dart';

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
    return BlocListener<UserBloc, UserBlocState>(
        listener: (context, state) {
          print(state.toString());
          if (state is SuccessProfileState) {

            store.set("nik", state.user.nik);
            store.set("branch_id", state.user.branch_id);
            store.set("login", state.user);
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => Dashboard()
            ));
          }
          if(state is LoadingUserState) {
            Container(
              child: const Center(
                child: CircularProgressIndicator(),
              )
            );
          }
          if (state is FailedUserState) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Global.defaultModal(() {
                    Navigator.pop(context);
                  }, context, Global.WARNING_ICON, "Wrong password", "Try again", false);
                }
            );
          }

        },
        child: GestureDetector (
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
        },
          child: SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.only(left: 21, right: 21),
                      margin: const EdgeInsets.only(top: 80),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 200,
                            child: Image.asset(
                              'assets/images/logo.png',
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
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
                                    borderSide: BorderSide()),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
                              maxLines: 1,
                              obscureText: true,
                              controller: passwordController,
                              onChanged: (text) {
                                pass = text;
                              },
                              decoration: InputDecoration(
                                labelText: "Password",
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius .circular(10),
                                    borderSide: BorderSide()),
                              ),
                            ),
                          ),
                          Container(
                            child: Stack(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 9),
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
                                          BlocProvider.of<UserBloc>(context).add(
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
                            ),
                          )
                        ] ,
                      )
                  ),
                )
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
