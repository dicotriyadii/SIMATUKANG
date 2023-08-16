import 'dart:async';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
// Page
import 'package:aplikasi_simatukang/login_view.dart';
import 'package:aplikasi_simatukang/register_view.dart';
import 'package:aplikasi_simatukang/user/keluhan_view.dart';
import 'package:flutter/material.dart';
// import 'package:aplikasi_simatukang/home/home_view.dart';

class registerPage extends StatefulWidget {
  const registerPage({Key? key}) : super(key: key);

  @override
  _registerPageState createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  TextEditingController nomorTelepon = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool passwordVisible = false;
  List? data;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  //
  Future<String> Register(String nomorTelepon, String password) async {
    final response = await http.post(
      Uri.parse('http://10.1.12.49/project/APISimatukang/api/Register'),
      // Uri.parse('https://wifitermurah.com/APIDokumentasi/api/Login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': 'ci_session=ik0j0msiovnqb1cic6hksgb7372jg79f'
      },
      body: jsonEncode(<String, String>{
        'nomorTelepon': nomorTelepon,
        'password': password,
        'role': 'user'
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        var resBody = json.decode(response.body);
        data = resBody;
      });
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        borderSide: const BorderSide(
          color: Colors.green,
          width: 2,
        ),
        width: 280,
        buttonsBorderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'Login Berhasil',
        desc: data?[0]['messages'].toString(),
        showCloseIcon: true,
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
      ).show();
      return "Success!";
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        borderSide: const BorderSide(
          color: Colors.green,
          width: 2,
        ),
        width: 280,
        buttonsBorderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'Login Gagal',
        desc: data?[0]['messages'].toString(),
        showCloseIcon: true,
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
      ).show();
      return "Gagal";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Center(
                child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/gambar2.jpg",
                          height: 300,
                          width: 300,
                          alignment: Alignment.bottomCenter,
                        ),
                        SizedBox(height: 50),
                        Container(
                          // padding: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Daftar Akun Kamu',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 23),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                'Isi Nomor Telepon dan Password anda',
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      controller: nomorTelepon,
                                      keyboardType: TextInputType.text,
                                      autofocus: false,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Masukkan Nomor Telepon Anda',
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Color.fromRGBO(
                                                  255, 202, 0, 1)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    TextFormField(
                                      obscureText: !passwordVisible,
                                      controller: password,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      autofocus: false,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        suffixIcon: IconButton(
                                          splashRadius: 1,
                                          icon: Icon(passwordVisible
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined),
                                          onPressed: togglePassword,
                                        ),
                                        hintText: 'Masukkan Password',
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 10.0, 20.0, 10.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                              width: 3,
                                              color: Color.fromRGBO(
                                                  255, 202, 0, 1)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 340,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromRGBO(
                                  255, 202, 0, 1), // Background color
                            ),
                            child: Text(
                              "Daftar Akun",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Register(nomorTelepon.text, password.text);
                            },
                          ),
                        ),
                        Container(
                            width: 340,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "Sudah Punya Akun ? ",
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.right,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                  },
                                  child: Container(
                                      child: Center(
                                    child: Text(
                                      "Masuk Sekarang ",
                                      style: TextStyle(color: Colors.orange),
                                      textAlign: TextAlign.right,
                                    ),
                                  )),
                                ),
                              ],
                            )),
                      ],
                    )))
          ],
        ));
  }
}
