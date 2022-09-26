import 'package:flutter/material.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);
  static String title = 'Home Pasien';

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Selamat datang \nAplikasi Smart Hospital',
        style: TextStyle(fontSize: 30),
        textAlign: TextAlign.center,
      ),
    );
  }
}
