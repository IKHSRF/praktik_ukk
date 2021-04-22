import 'package:flutter/material.dart';
import 'package:praktik_ukk/providers/pendaftarProvider.dart';
import 'package:praktik_ukk/services/firestoreServices.dart';
import 'package:provider/provider.dart';

class DaftarBaru extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pendaftaranProvider = Provider.of<PendaftarProvider>(context);
    int data;
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Baru"),
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: FutureBuilder(
              future: FirestoreServices().getLastPendaftar(),
              builder: (context, snapshot) {
                data = snapshot.data;
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(hintText: data.toString()),
                        readOnly: true,
                      ),
                      TextField(
                        decoration: InputDecoration(hintText: "Nama Lengkap"),
                        onChanged: (value) {
                          pendaftaranProvider.changeNamaLengkap = value;
                          pendaftaranProvider.changeNoDaftar = data;
                        },
                      ),
                      Container(
                        width: double.infinity,
                        height: 60.0,
                        child: DropdownButton(
                          value: pendaftaranProvider.jk,
                          hint: Text("Jenis Kelamin"),
                          items: [
                            DropdownMenuItem(
                              child: Text("Laki - Laki"),
                              value: 'Laki - laki',
                            ),
                            DropdownMenuItem(
                              child: Text("Perempuan"),
                              value: 'Perempuan',
                            ),
                          ],
                          onChanged: (value) {
                            pendaftaranProvider.changeJk = value;
                          },
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(hintText: "Alamat Lengkap"),
                        onChanged: (value) {
                          pendaftaranProvider.changeAlamatLengkap = value;
                        },
                      ),
                      Container(
                        width: double.infinity,
                        height: 60.0,
                        child: DropdownButton(
                          value: pendaftaranProvider.agama,
                          hint: Text("Agama"),
                          items: [
                            DropdownMenuItem(
                              child: Text("Islam"),
                              value: 'Islam',
                            ),
                            DropdownMenuItem(
                              child: Text("Kristen"),
                              value: 'Kristen',
                            ),
                            DropdownMenuItem(
                              child: Text("Buhda"),
                              value: 'Budha',
                            ),
                            DropdownMenuItem(
                              child: Text("Katolik"),
                              value: 'Katolik',
                            ),
                            DropdownMenuItem(
                              child: Text("Konghucu"),
                              value: 'Konghucu',
                            ),
                          ],
                          onChanged: (value) {
                            pendaftaranProvider.changeAgama = value;
                          },
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(hintText: "Asal SMP"),
                        onChanged: (value) {
                          pendaftaranProvider.changeAsalSmp = value;
                        },
                      ),
                      Container(
                        width: double.infinity,
                        height: 60.0,
                        child: DropdownButton(
                          value: pendaftaranProvider.jurusan,
                          hint: Text("Jurusan"),
                          items: [
                            DropdownMenuItem(
                              child: Text("Rekayasa Perangkat Lunak"),
                              value: 'RPL',
                            ),
                            DropdownMenuItem(
                              child: Text("Multimedia"),
                              value: 'MMD',
                            ),
                            DropdownMenuItem(
                              child: Text("Tata Boga"),
                              value: 'TBG',
                            ),
                            DropdownMenuItem(
                              child: Text("Tata Busana"),
                              value: 'TBN',
                            ),
                          ],
                          onChanged: (value) {
                            pendaftaranProvider.changeJurusan = value;
                          },
                        ),
                      ),
                      SizedBox(height: 40.0),
                      TextButton(
                        onPressed: () {
                          pendaftaranProvider.savePendaftar(context);
                        },
                        child: Text("Daftar"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
