import 'package:flutter/material.dart';
import 'package:smart_hospital/model/regis_poli.dart';
import 'package:smart_hospital/page/list_widget/regis_poli.dart';
import 'package:smart_hospital/page/modul_pasien/regis_poli/create.dart'
    as RegisPoliCreate;
import 'package:smart_hospital/util/util.dart';

class RegisPoliContent extends StatefulWidget {
  const RegisPoliContent({Key? key}) : super(key: key);
  static String title = "Registrasi Poli";

  @override
  State<RegisPoliContent> createState() => _RegisPoliContentState();
}

class _RegisPoliContentState extends State<RegisPoliContent> {
  late Future<List<RegisPoli>> regisPolis;

  @override
  void initState() {
    super.initState();
    regisPolis = fetchRegisPolis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const RegisPoliCreate.CreatePage()));
          if (result != null) {
            dialog(context, result);
            setState(() {
              regisPolis = fetchRegisPolis();
            });
          }
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.edit),
      ),
      body: Center(
        child: FutureBuilder(
            future: regisPolis,
            builder: (context, snapshot) {
              Widget result;
              if (snapshot.hasError) {
                result = Text('${snapshot.error}');
              } else if (snapshot.hasData) {
                result = RegisPoliList(regisPolis: snapshot.data as List<RegisPoli>);
              } else {
                result = const CircularProgressIndicator();
              }
              return result;
            }),
      ),
    );
  }
}
