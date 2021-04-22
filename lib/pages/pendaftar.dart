import 'package:flutter/material.dart';
import 'package:praktik_ukk/providers/pendaftarProvider.dart';
import 'package:praktik_ukk/services/auth_services.dart';
import 'package:praktik_ukk/services/generate_pdf.dart';
import 'package:provider/provider.dart';

class Pendaftar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pendaftarProvider = Provider.of<PendaftarProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: pendaftarProvider.pendaftar,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return SizedBox.expand(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              GeneratePdf().generate(snapshot);
                            },
                            child: Text(
                              "Print PDF",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green),
                            ),
                          ),
                          SizedBox(width: 30.0),
                          TextButton(
                            onPressed: () {
                              AuthServices.signOut();
                              Navigator.popAndPushNamed(context, '/');
                            },
                            child: Text(
                              "Logout",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                            ),
                          ),
                        ],
                      ),
                      DataTable(
                        columns: [
                          DataColumn(label: Text("No Daftar")),
                          DataColumn(label: Text("Nama Lengkap")),
                          DataColumn(label: Text("JK")),
                          DataColumn(label: Text("Alamat Lengkap")),
                          DataColumn(label: Text("Agama")),
                          DataColumn(label: Text("Asal SMP")),
                          DataColumn(label: Text("Jurusan")),
                          DataColumn(label: Text("Action")),
                        ],
                        rows: snapshot.data.map<DataRow>((doc) {
                          return DataRow(cells: [
                            DataCell(Text(doc.noDaftar.toString())),
                            DataCell(Text(doc.namaLengkap)),
                            DataCell(Text(doc.jk)),
                            DataCell(Text(doc.alamatLengkap)),
                            DataCell(Text(doc.agama)),
                            DataCell(Text(doc.asalSmp)),
                            DataCell(Text(doc.jurusan)),
                            DataCell(Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/editDaftar',
                                      arguments: doc.id,
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                              "Apakah Yakin Data Akan Dihapus?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "Batal",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                pendaftarProvider
                                                    .deletePendaftaran(
                                                  doc.id,
                                                  context,
                                                );
                                              },
                                              child: Text(
                                                "Ya",
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            )),
                          ]);
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
