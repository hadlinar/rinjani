import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class VisitBlocEvent{}

class GetVisitCategoryEvent extends VisitBlocEvent{}