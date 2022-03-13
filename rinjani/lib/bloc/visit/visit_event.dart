import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class VisitBlocEvent{}

class AddVisitEvent extends VisitBlocEvent{
  final String visit_cat;
  final String branch_id;
  final String cust_id;
  final String time_start;
  final String time_finish;
  final String user_id;
  final String description;
  final String pic_position;
  final String pic_name;
  final String status_visit;

  AddVisitEvent(
    this.visit_cat,
    this.branch_id,
    this.cust_id,
    this.time_start,
    this.time_finish,
    this.user_id,
    this.description,
    this.pic_position,
    this.pic_name,
    this.status_visit
  );
}

class AddRealizationEvent extends VisitBlocEvent{
  final String visit_no;
  final String branch_id;
  final String cust_id;
  final String time_start;
  final String time_finish;
  final String user_id;
  final String description;
  final String pic_position;
  final String pic_name;
  final String status_visit;
  final String latitude;
  final String longitude;

  AddRealizationEvent(
      this.visit_no,
      this.branch_id,
      this.cust_id,
      this.time_start,
      this.time_finish,
      this.user_id,
      this.description,
      this.pic_position,
      this.pic_name,
      this.status_visit,
      this.latitude,
      this.longitude,
    );
}

class GetVisitEvent extends VisitBlocEvent{}

class GetVisitByIdEvent extends VisitBlocEvent{
  String id;

  GetVisitByIdEvent(this.id);
}

class GetVisitCategoryEvent extends VisitBlocEvent{}

class GetVisitRealizationEvent extends VisitBlocEvent{}

class GetVisitRealizationByIdEvent extends VisitBlocEvent{
  String id;

  GetVisitRealizationByIdEvent(this.id);
}