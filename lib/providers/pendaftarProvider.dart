import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:praktik_ukk/models/pendaftaran.dart';
import 'package:praktik_ukk/services/firestoreServices.dart';

class PendaftarProvider with ChangeNotifier {
  final firestore = FirestoreServices();

  int _noDaftar;
  String _namaLengkap;
  String _jk;
  String _alamatLengkap;
  String _agama;
  String _asalSmp;
  String _jurusan;

  int get noDaftar => _noDaftar;
  String get namaLengkap => _namaLengkap;
  String get jk => _jk;
  String get alamatLengkap => _alamatLengkap;
  String get agama => _agama;
  String get asalSmp => _asalSmp;
  String get jurusan => _jurusan;

  Stream<List<Pendaftaran>> get pendaftar => firestore.getPendaftar();

  set changeNoDaftar(int value) {
    _noDaftar = value;
    notifyListeners();
  }

  set changeNamaLengkap(String value) {
    _namaLengkap = value;
    notifyListeners();
  }

  set changeJk(String value) {
    _jk = value;
    notifyListeners();
  }

  set changeAlamatLengkap(String value) {
    _alamatLengkap = value;
    notifyListeners();
  }

  set changeAgama(String value) {
    _agama = value;
    notifyListeners();
  }

  set changeAsalSmp(String value) {
    _asalSmp = value;
    notifyListeners();
  }

  set changeJurusan(String value) {
    _jurusan = value;
    notifyListeners();
  }

  //save database
  savePendaftar(BuildContext context) async {
    if (_namaLengkap == null ||
        _jk == null ||
        _alamatLengkap == null ||
        _agama == null ||
        _asalSmp == null ||
        _jurusan == null) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ada Data Yang Kosong")),
      );
    } else {
      var pendaftaran = Pendaftaran(
        noDaftar: _noDaftar,
        namaLengkap: _namaLengkap,
        jk: _jk,
        alamatLengkap: _alamatLengkap,
        agama: _agama,
        asalSmp: _asalSmp,
        jurusan: _jurusan,
      );

      var result = await firestore.addPendaftar(pendaftaran);
      if (result == 'ok') {
        _agama = null;
        _jk = null;
        _jurusan = null;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("“Selamat, Anda sudah terdaftar di SMK Semangat 45"),
          ),
        );
        return Navigator.popAndPushNamed(context, '/');
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
        );
      }
    }
  }

  //update database
  updatePendaftaran(
    String id,
    BuildContext context,
    DocumentSnapshot snapshot,
  ) async {
    var pendaftaran = Pendaftaran(
      noDaftar: snapshot.data()['noDaftar'],
      namaLengkap: _namaLengkap ?? snapshot.data()['namaLengkap'],
      jk: _jk ?? snapshot.data()['jk'],
      alamatLengkap: _alamatLengkap ?? snapshot.data()['alamatLengkap'],
      agama: _agama ?? snapshot.data()['agama'],
      asalSmp: _asalSmp ?? snapshot.data()['asalSmp'],
      jurusan: _jurusan ?? snapshot.data()['jurusan'],
    );
    var result = await firestore.updatePendaftar(id, pendaftaran);
    if (result == 'ok') {
      _agama = null;
      _jk = null;
      _jurusan = null;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data berhasil diubah!")),
      );
      return Navigator.popAndPushNamed(context, '/pendaftar');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  //delete
  deletePendaftaran(String id, BuildContext context) async {
    var result = await firestore.removePendaftar(id);

    if (result == 'ok') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data Sudah Dihapus")),
      );
      return Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }
}
