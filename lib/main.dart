import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_hospital/page/login.dart';
import 'package:smart_hospital/util/session.dart';
import 'package:smart_hospital/page/modul_pasien/index.dart' as IndexPasien;
import 'package:smart_hospital/page/modul_pegawai/index.dart' as IndexPegawai;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Hospital',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FutureBuilder(
        future: _loadSession(),
        builder: (context, snapshot) {
          late Widget result;
          if (snapshot.connectionState == ConnectionState.waiting) {
            result = const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            final SharedPreferences prefs = snapshot.data as SharedPreferences;
            if (snapshot.hasData) {
              if (prefs.getBool(IS_LOGIN) ?? false) {
                if (prefs.getString(JENIS_LOGIN) ==
                    jenisLogin.PASIEN.toString()) {
                  result = IndexPasien.IndexPage();
                } else {
                  //result home pegawai
                  result = IndexPegawai.IndexPage();
                }
              } else {
                result = LoginPage();
              }
            } else {
              return Container(
                child: Text('Error..'),
              );
            }
          }
          return result;
        },
      ),

    );
  }

  Future _loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}
