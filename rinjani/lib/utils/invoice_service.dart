import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:rinjani/models/pdf.dart';
// import 'package:pdf_invoice_generator_flutter/model/product.dart';

class CustomRow {
  final String itemName;
  final String itemPrice;
  final String amount;
  final String total;
  final String vat;

  CustomRow(this.itemName, this.itemPrice, this.amount, this.total, this.vat);
}

class PdfInvoiceService {
  Future<Uint8List> createHelloWorld() {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          );
        },
      ),
    );

    return pdf.save();
  }

  Future<Uint8List> createInvoice(List<PDF> data) async {
    final pdf = pw.Document();

    // "real_no": "RLS-2022-BGR-0001",
    // "visit_no": "VST-2022-BGR-0002",
    // "branch_id": "44",
    // "branch": "BOGOR",
    // "cust_id": "30103128",
    // "customer": "PT.INTI CAKRAWALA CITRA",
    // "email": "admin@nusindo.co.id",
    // "time_start": "2022-05-21T09:30:00.000Z",
    // "time_finish": "2022-05-21T10:30:00.000Z",
    // "user_id": "admin",
    // "employee": "ADMIN",
    // "description_real": "desc real",
    // "pic_position": "pic",
    // "pic_name": "name"

    final List<CustomRow> elements = [
      CustomRow("Item Name", "Item Price", "Amount", "Total", "Vat"),
      for (var product in data)
        CustomRow(
          product.time_finish,
          product.customer,
          product.pic_position,
          product.pic_name,
          product.description_real
        ),
    ];
    final image = (await rootBundle.load("assets/flutter_explained_logo.jpg")).buffer.asUint8List();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Image(pw.MemoryImage(image), width: 150, height: 150, fit: pw.BoxFit.cover),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    children: [
                      pw.Text("Name"),
                      pw.Text("NIK"),
                      pw.Text("Branch")
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.Text(data[0].employee),
                      pw.Text(data[0].user_id),
                      pw.Text(data[0].branch),
                    ],
                  )
                ],
              ),
              pw.SizedBox(height: 50),
              pw.Text(
                  "Dear Customer, thanks for buying at Flutter Explained, feel free to see the list of items below."),
              pw.SizedBox(height: 25),
              itemColumn(elements),
              pw.SizedBox(height: 25),
              pw.Text("Thanks for your trust, and till the next time."),
              pw.SizedBox(height: 25),
              pw.Text("Kind regards,"),
              pw.SizedBox(height: 25),
              pw.Text("Max Weber")
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

  pw.Expanded itemColumn(List<CustomRow> elements) {
    return pw.Expanded(
      child: pw.Column(
        children: [
          for (var element in elements)
            pw.Row(
              children: [
                pw.Expanded(child: pw.Text(element.itemName, textAlign: pw.TextAlign.left)),
                pw.Expanded(child: pw.Text(element.itemPrice, textAlign: pw.TextAlign.right)),
                pw.Expanded(child: pw.Text(element.amount, textAlign: pw.TextAlign.right)),
                pw.Expanded(child: pw.Text(element.total, textAlign: pw.TextAlign.right)),
                pw.Expanded(child: pw.Text(element.vat, textAlign: pw.TextAlign.right)),
              ],
            )
        ],
      ),
    );
  }
 
  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenDocument.openDocument(filePath: filePath);
  }

  // String getSubTotal(List<Product> products) {
  //   return products
  //       .fold(0.0, (double prev, element) => prev + (element.amount * element.price))
  //       .toStringAsFixed(2);
  // }
  //
  // String getVatTotal(List<Product> products) {
  //   return products
  //       .fold(
  //     0.0,
  //         (double prev, next) => prev + ((next.price / 100 * next.vatInPercent) * next.amount),
  //   )
  //       .toStringAsFixed(2);
  // }
}