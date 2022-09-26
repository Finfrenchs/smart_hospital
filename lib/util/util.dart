import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_hospital/page/login.dart';
import 'package:smart_hospital/util/session.dart';

dialog(_context, msg, {title}) {
  showDialog(
    context: _context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title ?? 'Perhatian!'),
        content: Text(msg),
      );
    },
  );
}

//Template button lebar untuk posisi bottomNavigationBar
Widget largetButton(
    {String label = "Simpan", IconData? iconData, required Function() onPressed}) {
  iconData = iconData ?? Icons.done_all;
  return SizedBox(
    height: 60,
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        iconData,
        color: Colors.white,
      ),
      label: Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
      //style: ElevatedButton.styleFrom(elevation: 4.0, backgroundColor: Colors.blue),
    ),
  );
}

//fungsi format tulisan rupiah
String toRupiah(int val) {
  return NumberFormat.currency(locale: 'IDR').format(val);
}

void logOut(BuildContext context) {
  clearSession().then((value) => Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return const LoginPage();
      }, transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      }),
      (route) => false));
}
