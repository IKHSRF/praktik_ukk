import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:praktik_ukk/models/pendaftaran.dart';

class FirestoreServices {
  CollectionReference pendaftar =
      FirebaseFirestore.instance.collection('pendaftar');

  Stream<List<Pendaftaran>> getPendaftar() =>
      pendaftar.orderBy('noDaftar').snapshots().map((snapshost) =>
          snapshost.docs.map((doc) => Pendaftaran.fromFirestore(doc)).toList());

  Future<String> addPendaftar(Pendaftaran pendaftaran) async {
    try {
      await pendaftar.add(pendaftaran.toFirestore());
      return 'ok';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  Future<String> updatePendaftar(String id, Pendaftaran pendaftaran) async {
    try {
      await pendaftar
          .doc(id)
          .set(pendaftaran.toFirestore(), SetOptions(merge: true));
      return 'ok';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  Future<String> removePendaftar(String id) async {
    try {
      await pendaftar.doc(id).delete();
      return 'ok';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  Future<int> getLastPendaftar() async {
    QuerySnapshot result = await pendaftar
        .orderBy('noDaftar', descending: false)
        .limitToLast(1)
        .get();

    if (result.docs.isNotEmpty) {
      return result.docs.first.data()['noDaftar'] + 1;
    } else {
      return 1;
    }
  }
}
