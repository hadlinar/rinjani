import 'package:json_annotation/json_annotation.dart';
part 'ranking.g.dart';

// "branch_id": "11",
// "branch_name": "KANTOR PUSAT",
// "nik": "1988402021",
// "name_emp": "CHRISTYARSIH,SE",
// "in_office": "0",
// "out_office": "0",
// "off_act": "0",
// "all_act": "0"

@JsonSerializable()
class Ranking{
  String branch_id;
  String branch_name;
  String nik;
  String name_emp;
  String in_office;
  String out_office;
  String off_act;
  String all_act;

  Ranking(
      this.branch_id,
      this.branch_name,
      this.nik,
      this.name_emp,
      this.in_office,
      this.out_office,
      this.off_act,
      this.all_act,
      );

  factory Ranking.fromJson(Map<String,dynamic> json) => _$RankingFromJson(json);
}

@JsonSerializable()
class RankingResponse{
  String message;
  List<Ranking> result;

  RankingResponse(this.message, this.result);

  factory RankingResponse.fromJson(Map<String,dynamic> json) => _$RankingResponseFromJson(json);
}