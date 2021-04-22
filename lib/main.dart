import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:praktik_ukk/pages/daftar_baru.dart';
import 'package:praktik_ukk/pages/edit.dart';
import 'package:praktik_ukk/pages/index.dart';
import 'package:praktik_ukk/pages/login.dart';
import 'package:praktik_ukk/pages/pendaftar.dart';
import 'package:praktik_ukk/providers/pendaftarProvider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PendaftarProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (_) => Index(),
          '/pendaftar': (_) => Pendaftar(),
          '/daftarBaru': (_) => DaftarBaru(),
          '/editDaftar': (_) => Edit(),
          '/login': (_) => LoginPage(),
        },
      ),
    );
  }
}
