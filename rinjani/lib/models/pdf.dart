import 'package:json_annotation/json_annotation.dart';
part 'pdf.g.dart';

@JsonSerializable()
class PDF{
  String real_no;
  String visit_no;
  String branch_id;
  String branch;
  String cust_id;
  String customer;
  String email;
  String time_start;
  String time_finish;
  String user_id;
  String employee;
  String description;
  String pic_position;
  String pic_name;

  PDF(
      this.real_no,
      this.visit_no,
      this.branch_id,
      this.branch,
      this.cust_id,
      this.customer,
      this.email,
      this.time_start,
      this.time_finish,
      this.user_id,
      this.employee,
      this.description,
      this.pic_position,
      this.pic_name
  );

  factory PDF.fromJson(Map<String,dynamic> json) => _$PDFFromJson(json);
}

@JsonSerializable()
class PDFResponse{
  String message;
  List<PDF> result;

  PDFResponse(this.message, this.result);

  factory PDFResponse.fromJson(Map<String,dynamic> json) => _$PDFResponseFromJson(json);
}