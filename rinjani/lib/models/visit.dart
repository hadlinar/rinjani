import 'package:json_annotation/json_annotation.dart';
part 'visit.g.dart';

@JsonSerializable()
class VisitCategory{
  static const SUCCESS_LOCATION = "ok";

  String visit_id;
  String visit_name;

  VisitCategory({this.visit_id, this.visit_name});

  factory VisitCategory.fromJson(Map<String,dynamic> json) => _$VisitCategoryFromJson(json);
}

@JsonSerializable()
class VisitCategoryResponse{
  String message;
  List<VisitCategory> result;

  VisitCategoryResponse(this.message, this.result);

  factory VisitCategoryResponse.fromJson(Map<String,dynamic> json) => _$VisitCategoryResponseFromJson(json);
}

@JsonSerializable()
class VisitReal{
  static const SUCCESS_LOCATION = "ok";

  String real_no;
  String visit_no;
  String branch_id;
  String cust_id;
  DateTime time_start;
  DateTime time_finish;
  String user_id;
  String description;
  String pic_position;
  String pic_name;
  String status_visit;
  double latitude;
  double longitude;

  VisitReal({
    this.real_no,
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
    this.longitude
  });

  factory VisitReal.fromJson(Map<String,dynamic> json) => _$VisitRealFromJson(json);
}

@JsonSerializable()
class VisitRealResponse{
  String message;
  List<VisitReal> result;

  VisitRealResponse(this.message, this.result);

  factory VisitRealResponse.fromJson(Map<String,dynamic> json) => _$VisitRealResponseFromJson(json);
}

@JsonSerializable()
class PostVisit{
  static const SUCCESS_LOCATION = "ok";

  String visit_cat;
  String branch_id;
  String cust_id;
  String time_start;
  String time_finish;
  String user_id;
  String description;
  String pic_position;
  String pic_name;
  String status_visit;


  PostVisit({
    this.visit_cat,
    this.branch_id,
    this.cust_id,
    this.time_start,
    this.time_finish,
    this.user_id,
    this.description,
    this.pic_position,
    this.pic_name,
    this.status_visit,
  });

  factory PostVisit.fromJson(Map<String,dynamic> json) => _$PostVisitFromJson(json);
}

@JsonSerializable()
class PostVisitResponse{
  String message;
  // List<PostVisit> result;

  PostVisitResponse(this.message);

  factory PostVisitResponse.fromJson(Map<String,dynamic> json) => _$PostVisitResponseFromJson(json);
}

@JsonSerializable()
class PostReal{
  static const SUCCESS_LOCATION = "ok";

        String visit_no;
        String branch_id;
        String cust_id;
        String time_start;
        String time_finish;
        String description;
        String pic_position;
        String pic_name;
        String status_visit;
        String latitude;
        String longitude;


  PostReal({
    this.visit_no,
    this.branch_id,
    this.cust_id,
    this.time_start,
    this.time_finish,
    this.description,
    this.pic_position,
    this.pic_name,
    this.status_visit,
    this.latitude,
    this.longitude,
  });

  factory PostReal.fromJson(Map<String,dynamic> json) => _$PostRealFromJson(json);
}

@JsonSerializable()
class PostRealResponse{
  String message;
  // PostReal result;

  PostRealResponse(this.message);

  factory PostRealResponse.fromJson(Map<String,dynamic> json) => _$PostRealResponseFromJson(json);
}

@JsonSerializable()
class Visit{
  String visit_no;
  String visit_cat;
  String branch_id;
  String cust_id;
  DateTime time_start;
  DateTime time_finish;
  String user_id;
  String description;
  String pic_position;
  String pic_name;
  String status_visit;

  Visit({
    this.visit_no,
    this.visit_cat,
    this.branch_id,
    this.cust_id,
    this.time_start,
    this.time_finish,
    this.user_id,
    this.description,
    this.pic_position ,
    this.pic_name,
    this.status_visit,
  });

  factory Visit.fromJson(Map<String,dynamic> json) => _$VisitFromJson(json);
}


@JsonSerializable()
class VisitResponse{
  String message;
  List<Visit> result;

  VisitResponse(this.message, this.result);

  factory VisitResponse.fromJson(Map<String,dynamic> json) => _$VisitResponseFromJson(json);
}

@JsonSerializable()
class VisitById{
  String visit_no;
  String visit_cat;
  String branch_id;
  String cust_id;
  DateTime time_start;
  DateTime time_finish;
  String description;
  String pic_position;
  String pic_name;
  String status_visit;

  VisitById({
    this.visit_no,
    this.visit_cat,
    this.branch_id,
    this.cust_id,
    this.time_start,
    this.time_finish,
    this.description,
    this.pic_position ,
    this.pic_name,
    this.status_visit,
  });

  factory VisitById.fromJson(Map<String,dynamic> json) => _$VisitByIdFromJson(json);
}


@JsonSerializable()
class VisitByIdResponse{
  String message;
  List<VisitById> result;

  VisitByIdResponse(this.message, this.result);

  factory VisitByIdResponse.fromJson(Map<String,dynamic> json) => _$VisitByIdResponseFromJson(json);
}

@JsonSerializable()
class VisitRealById{
  static const SUCCESS_LOCATION = "ok";

  String real_no;
  String visit_no;
  String branch_id;
  String cust_id;
  DateTime time_start;
  DateTime time_finish;
  String description;
  String pic_position;
  String pic_name;
  String status_visit;
  double latitude;
  double longitude;

  VisitRealById({
    this.real_no,
    this.visit_no,
    this.branch_id,
    this.cust_id,
    this.time_start,
    this.time_finish,
    this.description,
    this.pic_position,
    this.pic_name,
    this.status_visit,
    this.latitude,
    this.longitude
  });

  factory VisitRealById.fromJson(Map<String,dynamic> json) => _$VisitRealByIdFromJson(json);
}

@JsonSerializable()
class VisitRealByIdResponse{
  String message;
  List<VisitRealById> result;

  VisitRealByIdResponse(this.message, this.result);

  factory VisitRealByIdResponse.fromJson(Map<String,dynamic> json) => _$VisitRealByIdResponseFromJson(json);
}