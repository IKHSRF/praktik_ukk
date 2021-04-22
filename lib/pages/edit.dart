import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:praktik_ukk/providers/pendaftarProvider.dart';
import 'package:provider/provider.dart';

class Edit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pendaftaranProvider = Provider.of<PendaftarProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Pendaftar"),
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('pendaftar')
                .doc(ModalRoute.of(context).settings.arguments)
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.all(40.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: snapshot.data['noDaftar'].toString(),
                        ),
                        readOnly: true,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: snapshot.data['namaLengkap'],
                        ),
                        onChanged: (value) {
                          pendaftaranProvider.changeNamaLengkap = value;
                        },
                      ),
                      Container(
                        width: double.infinity,
                        height: 60.0,
                        child: DropdownButton(
                          value: pendaftaranProvider.jk,
                          hint: Text(snapshot.data['jk']),
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
                        decoration: InputDecoration(
                          hintText: snapshot.data['alamatLengkap'],
                        ),
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
                        decoration: InputDecoration(
                          hintText: snapshot.data['asalSmp'],
                        ),
                        onChanged: (value) {
                          pendaftaranProvider.changeAsalSmp = value;
                        },
                      ),
                      Container(
                        width: double.infinity,
                        height: 60.0,
                        child: DropdownButton(
                          value: pendaftaranProvider.jurusan,
                          hint: Text(snapshot.data['jurusan']),
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
                          pendaftaranProvider.updatePendaftaran(
                            snapshot.data.id,
                            context,
                            snapshot.data,
                          );
                        },
                        child: Text("Edit"),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
