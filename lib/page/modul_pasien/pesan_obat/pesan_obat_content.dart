import 'package:flutter/material.dart';
import 'package:smart_hospital/model/pesan_obat.dart';
import 'package:smart_hospital/page/list_widget/pesan_obat.dart';
import 'package:smart_hospital/page/modul_pasien/pesan_obat/create.dart'
    as PesanObatCreate;
import 'package:smart_hospital/util/util.dart';

class PesanObatContent extends StatefulWidget {
  static String title = "Pesan Obat";

  const PesanObatContent({Key? key}) : super(key: key);

  @override
  State<PesanObatContent> createState() => _PesanObatContentState();
}

class _PesanObatContentState extends State<PesanObatContent> {
  late Future<List<PesanObat>> pesanObats;

  @override
  void initState() {
    super.initState();
    pesanObats = fetchPesanObat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PesanObatCreate.CreatePage()));
          if (result != null) {
            dialog(context, result);
            setState(() {
              pesanObats = fetchPesanObat();
            });
          }
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: FutureBuilder(
            future: pesanObats,
            builder: (context, snapshot) {
              Widget result;
              if (snapshot.hasError) {
                result = Text('${snapshot.error}');
              } else if (snapshot.hasData) {
                result = PesanObatList(pesanObats: snapshot.data as List<PesanObat>);
              } else {
                result = const CircularProgressIndicator();
              }
              return result;
            }),
      ),
    );
  }
}
