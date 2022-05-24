import '../../models/pdf.dart';
import '../network/pdf_service.dart';

class PDFRepository {
  final PDFService pdfService;

  PDFRepository(this.pdfService);

  Future<PDFResponse> getPDF(String token, String startDate, String endDate) async {
    final response = await pdfService.getPDF(token, startDate, endDate);
    return response;
  }
}