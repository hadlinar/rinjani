import 'package:meta/meta.dart';

import '../../models/pdf.dart';

@immutable
abstract class PDFBlocState {}

class InitialPDFBlocState extends PDFBlocState {}

class LoadingPDFState extends PDFBlocState{}

class SuccessPDFState extends PDFBlocState{}

class FailedPDFState extends PDFBlocState{}

class GetPDFState extends PDFBlocState{
  List<PDF> getPDF;

  GetPDFState(this.getPDF);
}
