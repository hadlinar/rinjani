// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RoleService implements RoleService {
  _RoleService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://172.20.30.22:3000';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<RoleResponse> getRole() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/role',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = RoleResponse.fromJson(_result.data);
    return value;
  }
}
