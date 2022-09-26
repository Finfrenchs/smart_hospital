import 'package:flutter/material.dart';
import 'package:smart_hospital/page/modul_pasien/home/home_content.dart';
import 'package:smart_hospital/page/modul_pasien/pesan_obat/pesan_obat_content.dart';
import 'package:smart_hospital/page/modul_pasien/regis_poli/regis_poli_content.dart';
import 'package:smart_hospital/util/util.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _selectedIndex = 1;
  Widget _selectedContent = HomeContent();
  String _selectedTitle = HomeContent.title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedTitle),
        actions: <Widget>[
          IconButton(
              onPressed: () => logOut(context),
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ))
        ],
      ),
      body: _selectedContent,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: 'Regis Poli'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital), label: 'Pesan Obat'),
        ],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _selectedContent = const RegisPoliContent();
          _selectedTitle = RegisPoliContent.title;
          break;

        case 1:
          _selectedContent = const HomeContent();
          _selectedTitle = HomeContent.title;
          break;

        case 2:
          _selectedContent = const PesanObatContent();
          _selectedTitle = PesanObatContent.title;
          break;
      }
    });
  }
}
