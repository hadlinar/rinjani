import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/visit/visit_bloc.dart';

class Rank extends StatefulWidget {
  @override
  _RankState createState() => _RankState();
}

class _RankState extends State<Rank> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<VisitBloc>(context).add(GetRankEvent("highest"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.yellow,
    );
  }
}