import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:smart_hospital/util/util.dart';
import 'package:smart_hospital/model/pasien.dart';
import 'package:smart_hospital/page/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namaCount = TextEditingController();
  TextEditingController hpCount = TextEditingController();
  TextEditingController emailCount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green,
        body: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'SMART HOSPITAL',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: _formWidget(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          //Nama
          TextFormField(
            controller: namaCount,
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Nama Lengkap',
            ),
            validator: (value) {
              if (value != null && value.isEmpty) {
                return 'Tidak boleh kosong';
              }
              return null;
            },
          ),
          //Nomor HP
          TextFormField(
            controller: hpCount,
            decoration: InputDecoration(
              icon: Icon(Icons.phone_android),
              hintText: 'Nomor HP',
            ),
            validator: (value) {
              if (value != null && value.isEmpty) {
                return 'Tidak boleh kosong';
              }
              return null;
            },
          ),
          //email
          TextFormField(
            controller: emailCount,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email),
              hintText: 'Email',
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          //Button Register
          SizedBox(
            width: double.infinity,
            child: largetButton(
              label: 'REGISTRASI PASIEN',
              onPressed: () async => (_formKey.currentState!.validate())
                  ? prosesRegistrasi()
                  : null,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage())),
            child: Text('Anda sudah punya akun? Login'),
          ),
        ],
      ),
    );
  }

  void prosesRegistrasi() async {
    final response = await pasienCreate(Pasien(
        nama: namaCount.text, hp: hpCount.text, email: emailCount.text));

    if (response != null) {
      print(response.body.toString());
      if (response.statusCode == 200) {
        var jsonResp = json.decode(response.body);
        Navigator.pop(context, jsonResp['message']);
      } else {
        dialog(context, response.body.toString());
      }
    }
  }
}
