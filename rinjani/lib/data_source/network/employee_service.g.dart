// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _EmployeeService implements EmployeeService {
  _EmployeeService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://172.20.30.22:3000';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<EmployeeResponse> getEmployee() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/employee',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = EmployeeResponse.fromJson(_result.data);
    return value;
  }
}
