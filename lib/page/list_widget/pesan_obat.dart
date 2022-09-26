import 'package:flutter/material.dart';
import 'package:smart_hospital/model/pesan_obat.dart';
import 'package:smart_hospital/util/util.dart';

class PesanObatList extends StatefulWidget {
  final List<PesanObat> pesanObats;

  const PesanObatList({Key? key, required this.pesanObats}) : super(key: key);

  @override
  State<PesanObatList> createState() => _PesanObatListState();
}

class _PesanObatListState extends State<PesanObatList> {
  @override
  Widget build(BuildContext context) {
    return (widget.pesanObats.length != 0)
        ? ListView.builder(
            itemCount:
                (widget.pesanObats.length),
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
                          leading: const Icon(Icons.local_hospital),
                          isThreeLine: true,
                          title: Text("${widget.pesanObats[i].waktu}"),
                          subtitle: Text("${widget.pesanObats[i].listPesanan} \n${widget.pesanObats[i].alamat} \n${widget.pesanObats[i].ket}"),
                          trailing: Text(toRupiah(int.parse(
                              widget.pesanObats[i].totalBiaya))),
                        ),
                        ButtonBar(
                          children: <Widget>[
                            Visibility(
                              visible: widget.pesanObats[i].isSelesai ?? false,
                              child: TextButton(
                                onPressed: () async {
                                  final result = await deletePesanObat(
                                      widget.pesanObats[i].idPesanObat);
                                  dialog(context, result);
                                  setState(() {
                                    widget.pesanObats.removeAt(i);
                                  });
                                },
                                child: const Text('HAPUS'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            })
        : Text('Tidak ada riwayat pesanan');
  }
}
