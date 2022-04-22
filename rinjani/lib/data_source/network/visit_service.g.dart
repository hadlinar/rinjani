// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _VisitService implements VisitService {
  _VisitService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://10.0.2.2:3001/rinjani';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<VisitCategoryResponse> getVisitCategory() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VisitCategoryResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/visit/category',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VisitCategoryResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VisitResponse> getAllVisit() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VisitResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/visits',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VisitResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VisitResponse> getVisit(authorization) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VisitResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/visit',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VisitResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VisitResponse> getVisitForRealization(authorization) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VisitResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/visit/all',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VisitResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RealizationResponse> getRealization(authorization, filter) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RealizationResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/realization/${filter}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RealizationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RealizationResponse> getRealizationOp(branchId, filter) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RealizationResponse>(Options(
                method: 'GET', headers: _headers, extra: _extra)
            .compose(
                _dio.options, '/realization_operasional/${branchId}/${filter}',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RealizationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostVisitResponse> addVisit(authorization, body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostVisitResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/visit',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostVisitResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PostRealResponse> addRealization(authorization, body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PostRealResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/realization',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PostRealResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DeleteVisitResponse> deleteVisit(authorization, visitNo) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DeleteVisitResponse>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options, '/visit/${visitNo}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DeleteVisitResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<PDFResponse> getPDF(authorization, startDate, endDate) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': authorization};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PDFResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/pdf/${startDate}/${endDate}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PDFResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
