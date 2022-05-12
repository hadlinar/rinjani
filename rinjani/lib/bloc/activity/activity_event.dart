import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ActivityBlocEvent{}

class GetActivityEvent extends ActivityBlocEvent{
  String branchId;

  GetActivityEvent(this.branchId);
}