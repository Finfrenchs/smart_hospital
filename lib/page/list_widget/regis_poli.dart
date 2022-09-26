import 'package:flutter/material.dart';
import 'package:smart_hospital/model/regis_poli.dart';
import 'package:smart_hospital/util/util.dart';

class RegisPoliList extends StatefulWidget {
  const RegisPoliList({Key? key, required this.regisPolis}) : super(key: key);
  final List<RegisPoli> regisPolis;

  @override
  State<RegisPoliList> createState() => _RegisPoliListState();
}

class _RegisPoliListState extends State<RegisPoliList> {
  @override
  Widget build(BuildContext context) {
    return (widget.regisPolis.length != 0)
        ? ListView.builder(
            itemCount:
                (widget.regisPolis.length),
            itemBuilder: (context, i) {
              return Container(
                child: GestureDetector(
                  onTap: null,
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.assignment),
                          isThreeLine: true,
                          title:
                              Text("${widget.regisPolis[i].idDokter.nama}"),
                          subtitle: Text("${widget.regisPolis[i].tglBooking}"),
                          trailing: Text("${widget.regisPolis[i].poli}"),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            ElevatedButton(
                                onPressed: () async {
                                  final result = await deleteRegisPoli(
                                      widget.regisPolis[i].idRegisPoli);
                                  dialog(context, result);
                                  setState(() {
                                    widget.regisPolis.removeAt(i);
                                  });
                                },
                                child: Text("HAPUS"))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            })
        : Text('Tidak ada riwayat registrasi');
  }
}
