import 'package:json_annotation/json_annotation.dart';
part 'visit.g.dart';

@JsonSerializable()
class VisitCategory{
  static const SUCCESS_LOCATION = "ok";

  String visit_id;
  String visit_name;

  VisitCategory({required this.visit_id, required this.visit_name});

  factory VisitCategory.fromJson(Map<String,dynamic> json) => _$VisitCategoryFromJson(json);
}

@JsonSerializable()
class VisitCategoryResponse{
  String message;
  List<VisitCategory> result;

  VisitCategoryResponse(this.message, this.result);

  factory VisitCategoryResponse.fromJson(Map<String,dynamic> json) => _$VisitCategoryResponseFromJson(json);
}