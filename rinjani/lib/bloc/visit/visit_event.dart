import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class VisitBlocEvent{}

class AddVisitEvent extends VisitBlocEvent{
  final String visit_id;
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
      this.visit_id,
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
  final String description_real;

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
      this.description_real
      );
}

class GetVisitCategoryEvent extends VisitBlocEvent{}

class GetAllVisitEvent extends VisitBlocEvent{}

class GetVisitEvent extends VisitBlocEvent{}

class GetVisitForRealizationEvent extends VisitBlocEvent{}

class GetRealizationEvent extends VisitBlocEvent{
  String filter;

  GetRealizationEvent(this.filter);
}

class GetRealizationOpEvent extends VisitBlocEvent{
  String id;
  String filter;

  GetRealizationOpEvent(this.id, this.filter);
}

class DeleteVisitEvent extends VisitBlocEvent{
  String visitNo;

  DeleteVisitEvent(this.visitNo);
}

class GetPDFEvent extends VisitBlocEvent{
  String startDate;
  String endDate;

  GetPDFEvent(this.startDate, this.endDate);
}