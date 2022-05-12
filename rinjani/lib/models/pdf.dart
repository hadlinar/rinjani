import 'package:json_annotation/json_annotation.dart';
part 'pdf.g.dart';


// "message": "ok",
// "result": [
// {
// "real_no": "RLS-2022-BGR-0001",
// "visit_no": "VST-2022-BGR-0001",
// "branch_id": "44",
// "branch": "BOGOR",
// "cust_id": "CUST-2022-0001",
// "customer": "test new cust",
// "email": "admin@nusindo.co.id",
// "time_start": "2022-04-27T01:30:00.000Z",
// "time_finish": "2022-04-27T02:54:12.863Z",
// "user_id": "admin",
// "employee": "ADMIN",
// "description_real": "changed desc",
// "pic_position": "pos",
// "pic_name": "name"

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
  String description_real;
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
      this.description_real,
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