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
    required this.real_no,
    required this.visit_no,
    required this.branch_id,
    required this.cust_id,
    required this.time_start,
    required this.time_finish,
    required this.user_id,
    required this.description,
    required this.pic_position,
    required this.pic_name,
    required this.status_visit,
    required this.latitude,
    required this.longitude
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
  DateTime time_start;
  DateTime time_finish;
  String user_id;
  String description;
  String pic_position;
  String pic_name;
  String status_visit;


  PostVisit({
    required this.visit_cat,
    required this.branch_id,
    required this.cust_id,
    required this.time_start,
    required this.time_finish,
    required this.user_id,
    required this.description,
    required this.pic_position,
    required this.pic_name,
    required this.status_visit,
  });

  factory PostVisit.fromJson(Map<String,dynamic> json) => _$PostVisitFromJson(json);
}

@JsonSerializable()
class PostVisitResponse{
  String message;
  List<PostVisit> result;

  PostVisitResponse(this.message, this.result);

  factory PostVisitResponse.fromJson(Map<String,dynamic> json) => _$PostVisitResponseFromJson(json);
}

@JsonSerializable()
class PostReal{
  static const SUCCESS_LOCATION = "ok";

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


  PostReal({
    required this.visit_no,
    required this.branch_id,
    required this.cust_id,
    required this.time_start,
    required this.time_finish,
    required this.user_id,
    required this.description,
    required this.pic_position,
    required this.pic_name,
    required this.status_visit,
    required this.latitude,
    required this.longitude,
  });

  factory PostReal.fromJson(Map<String,dynamic> json) => _$PostRealFromJson(json);
}

@JsonSerializable()
class PostRealResponse{
  String message;
  List<PostReal> result;

  PostRealResponse(this.message, this.result);

  factory PostRealResponse.fromJson(Map<String,dynamic> json) => _$PostRealResponseFromJson(json);
}

// "visit_no": "VST-2022-JK1-0001",
// "visit_cat": "01",
// "branch_id": "12",
// "cust_id": "",
// "time_start": "2022-03-04T08:29:13.000Z",
// "time_finish": "2022-03-04T08:29:13.000Z",
// "user_id": "1984409004",
// "description": "test description",
// "pic_position": "",
// "pic_name": "",
// "status_visit": "n"

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
    required this.visit_no,
    required this.visit_cat,
    required this.branch_id,
    required this.cust_id,
    required this.time_start,
    required this.time_finish,
    required this.user_id,
    required this.description,
    required this.pic_position ,
    required this.pic_name,
    required this.status_visit,
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