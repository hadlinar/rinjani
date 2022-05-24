import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PDFBlocEvent{}

class GetPDFEvent extends PDFBlocEvent{
  String startDate;
  String endDate;

  GetPDFEvent(this.startDate, this.endDate);
}