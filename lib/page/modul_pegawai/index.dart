import 'package:flutter/material.dart';
import 'package:smart_hospital/model/pesan_obat.dart';
import 'package:smart_hospital/page/list_widget/pesan_obat_pegawai.dart';
import 'package:smart_hospital/util/util.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  late Future<List<PesanObat>> pesanObats;

  @override
  void initState() {
    super.initState();
    _reloadData();
  }

  _reloadData() {
    setState(() {
      pesanObats = fetchPesanObat(isSelesai: '0');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Index Pegawai'),
        actions: <Widget>[
          IconButton(
              onPressed: () => logOut(context),
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ))
        ],
      ),
      body: Center(
        child: FutureBuilder(
            future: pesanObats,
            builder: (context, snapshot) {
              Widget result;
              if (snapshot.hasError) {
                result = Text('${snapshot.error}');
              } else if (snapshot.hasData) {
                result = PesanObatPegawaiList(
                    parentAction: _reloadData(), pesanObats: snapshot.data as List<PesanObat>);
              } else {
                result = const CircularProgressIndicator();
              }
              return result;
            }),
      ),
    );
  }
}
