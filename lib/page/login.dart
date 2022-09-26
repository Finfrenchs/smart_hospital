import 'package:flutter/material.dart';
import 'package:smart_hospital/model/user.dart';
import 'package:smart_hospital/page/modul_pasien/signup.dart';
import 'package:smart_hospital/util/session.dart';
import 'package:smart_hospital/util/util.dart';
import 'dart:convert';
import 'package:smart_hospital/page/modul_pegawai/index.dart' as IndexPegawai;
import 'package:smart_hospital/page/modul_pasien/index.dart' as IndexPasien;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameCount = TextEditingController();
  TextEditingController passCount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green,
        body: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'SMART HOSPITAL',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
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
          //Username
          TextFormField(
            controller: usernameCount,
            decoration:
                const InputDecoration(icon: Icon(Icons.person), hintText: 'Username'),
            validator: (value) {
              if (value != null && value.isEmpty) {
                return 'Tidak Boleh Kosong';
              }
              return null;
            },
          ),
          //Password
          TextFormField(
            controller: passCount,
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.vpn_key),
              hintText: 'Password',
            ),
            validator: (value) {
              if (value != null && value.isEmpty) {
                return 'Tidak boleh kosong';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          //button login
          SizedBox(
            width: double.infinity,
            child: largetButton(
                label: 'LOGIN',
                iconData: Icons.subdirectory_arrow_right,
                onPressed: () =>
                    (_formKey.currentState!.validate()) ? prosesLogin() : null),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async {
              final result = await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const SignUpPage()));
              if (result != null) {
                dialog(context, result);
              }
            },
            child: const Text('Anda belum punya akun? Registrasi pasien baru'),
          ),
        ],
      ),
    );
  }

  void prosesLogin() async {
    try {
      final response = await login(
          User(username: usernameCount.text, password: passCount.text));
      var jsonResp = json.decode(response.body);

      if (response.statusCode == 200) {
        User user = User.fromJson(jsonResp['user']);
        if (user.idPasien != null) {
          //direct to home pasien
          createPasienSession(user.idPasien!);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => IndexPasien.IndexPage()));
        } else {
          //direct to home pegawai here
          createPegawaiSession(jsonResp['user']['username']);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => IndexPegawai.IndexPage()));
        }
      } else if (response.statusCode == 401) {
        dialog(context, jsonResp['message']);
      } else {
        dialog(context, response.body.toString());
      }
    } catch (e) {
      dialog(context, e.toString());
    }
  }
}
