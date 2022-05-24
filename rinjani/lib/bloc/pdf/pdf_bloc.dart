import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../../data_source/repository/pdf_repository.dart';
import 'pdf_state.dart';
import 'pdf_event.dart';
import 'pdf_bloc.dart';

export 'pdf_state.dart';
export 'pdf_event.dart';
export 'pdf_bloc.dart';

class PDFBloc extends Bloc<PDFBlocEvent, PDFBlocState> {
  final PDFRepository _pdfRepository;
  final SharedPreferences _sharedPreferences;

  static create(PDFRepository pdfRepository, SharedPreferences sharedPreferences) => PDFBloc._(pdfRepository, sharedPreferences);

  PDFBloc._(this._pdfRepository, this._sharedPreferences);

  @override
  PDFBlocState get initialState => InitialPDFBlocState();

  @override
  Stream<PDFBlocState> mapEventToState(PDFBlocEvent event) async* {
    if(event is GetPDFEvent) {
      yield* _mapGetPDFToState(event);
    }
  }

  Stream<PDFBlocState> _mapGetPDFToState(GetPDFEvent e) async* {
    yield LoadingPDFState();
    final token = _sharedPreferences.getString("access_token");
    try{
      final response = await _pdfRepository.getPDF("Bearer $token", e.startDate, e.endDate);
      if (response.message == "ok") {
        yield GetPDFState(response.result);
      }
    } on DioError catch(e) {
      if(e.response?.statusCode == 500) {
        yield FailedPDFState();
      }
    }
  }
}