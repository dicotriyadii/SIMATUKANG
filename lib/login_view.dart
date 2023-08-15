import 'dart:async';

import 'package:aplikasi_simatukang/login_view.dart';
import 'package:aplikasi_simatukang/register_view.dart';
import 'package:aplikasi_simatukang/user/keluhan_view.dart';
import 'package:aplikasi_simatukang/user/profil_view.dart';
import 'package:aplikasi_simatukang/user/dashboard_view.dart';
import 'package:aplikasi_simatukang/admin/dashboardAdmin_view.dart';
import 'package:flutter/material.dart';
// import 'package:aplikasi_simatukang/home/home_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nomorTelepon = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool passwordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
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
                          "assets/images/LogoSimatukangText2.png",
                          height: 300,
                          width: 300,
                          alignment: Alignment.bottomCenter,
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Silahkan Masuk Dengan Akun Anda',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 23),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Silahkan masuk dengan username dan password yang terdaftar',
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
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
                              "Masuk",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => dashboardAdminPage()),
                              );
                            },
                          ),
                        ),
                        Container(
                            width: 340,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "Belum Punya Akun ? ",
                                  style: TextStyle(color: Colors.black),
                                  textAlign: TextAlign.right,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                registerPage()));
                                  },
                                  child: Container(
                                      child: Center(
                                    child: Text(
                                      "Daftar Sekarang ",
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
