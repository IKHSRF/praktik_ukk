import 'package:flutter/cupertino.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class GeneratePdf {
  Future<void> generate(AsyncSnapshot snapshot) async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a3,
        build: (pw.Context context) {
          return pw.Table.fromTextArray(
            headers: [
              'No Daftar',
              'Nama Lengkap',
              'JK',
              'Alamat Lengkap',
              'Agama',
              'Asal SMP',
              'Jurusan',
            ],
            data: snapshot.data.map<List<dynamic>>(
              (doc) {
                return [
                  doc.noDaftar,
                  doc.namaLengkap,
                  doc.jk,
                  doc.alamatLengkap,
                  doc.agama,
                  doc.asalSmp,
                  doc.jurusan,
                ];
              },
            ).toList(),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
    );
  }
}
