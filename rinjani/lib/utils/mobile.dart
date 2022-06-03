import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final path = (await getExternalStorageDirectory())!.path;
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  print("$path/$fileName");
  // SfPdfViewer.file(
  //     File('storage/emulated/0/Download/flutter-succinctly.pdf')
  // );
  OpenFile.open('$path/$fileName');
}