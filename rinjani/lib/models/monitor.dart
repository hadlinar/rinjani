import 'package:json_annotation/json_annotation.dart';
part 'monitor.g.dart';

// "branch_id": "11",
// "branch_name": "KANTOR PUSAT",
// "in_office": "0",
// "out_office": "0",
// "off_act": "0",
// "all_act": "0"

@JsonSerializable()
class Monitor{
  String branch_id;
  String branch_name;
  String in_office;
  String out_office;
  String off_act;
  String all_act;

  Monitor(
      this.branch_id,
      this.branch_name,
      this.in_office,
      this.out_office,
      this.off_act,
      this.all_act,
      );

  factory Monitor.fromJson(Map<String,dynamic> json) => _$MonitorFromJson(json);
}

@JsonSerializable()
class MonitorResponse{
  String message;
  List<Monitor> result;

  MonitorResponse(this.message, this.result);

  factory MonitorResponse.fromJson(Map<String,dynamic> json) => _$MonitorResponseFromJson(json);
}