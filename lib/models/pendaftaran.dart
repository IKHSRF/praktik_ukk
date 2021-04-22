import 'package:cloud_firestore/cloud_firestore.dart';

class Pendaftaran {
  final String id;
  final int noDaftar;
  final String namaLengkap;
  final String jk;
  final String alamatLengkap;
  final String agama;
  final String asalSmp;
  final String jurusan;

  Pendaftaran({
    this.id,
    this.noDaftar,
    this.namaLengkap,
    this.jk,
    this.alamatLengkap,
    this.agama,
    this.asalSmp,
    this.jurusan,
  });

  factory Pendaftaran.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data();

    return Pendaftaran(
      id: snapshot.id,
      noDaftar: data['noDaftar'],
      namaLengkap: data['namaLengkap'],
      jk: data['jk'],
      alamatLengkap: data['alamatLengkap'],
      agama: data['agama'],
      asalSmp: data['asalSmp'],
      jurusan: data['jurusan'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'noDaftar': noDaftar,
      'namaLengkap': namaLengkap,
      'jk': jk,
      'alamatLengkap': alamatLengkap,
      'agama': agama,
      'asalSmp': asalSmp,
      'jurusan': jurusan
    };
  }
}
