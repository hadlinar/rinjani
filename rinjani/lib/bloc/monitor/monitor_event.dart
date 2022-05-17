import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MonitorBlocEvent{}

class GetMonitorEvent extends MonitorBlocEvent{}
