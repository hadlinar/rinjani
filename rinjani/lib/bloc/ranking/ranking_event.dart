import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RankingBlocEvent{}

class GetRankingEvent extends RankingBlocEvent{}
