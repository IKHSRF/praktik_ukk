import 'package:flutter/material.dart';

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("PPDB SMK Semangat 45"),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/daftarBaru');
              },
              child: Text("Daftar Baru"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text("Pendaftar"),
            ),
          ],
        ),
      ),
    );
  }
}
