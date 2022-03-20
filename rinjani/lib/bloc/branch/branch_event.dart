import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BranchBlocEvent{}

class GetBranchEvent extends BranchBlocEvent{}