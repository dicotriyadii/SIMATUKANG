import 'dart:io';
// import 'package:aplikasi_keluhan/Home/profile_view.dart';
// import 'package:aplikasi_keluhan/Home/riwayat_view.dart';
import 'package:aplikasi_simatukang/login_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';

//page
// import 'package:aplikasi_keluhan/home/home_view.dart';

class keluhanPage extends StatefulWidget {
  keluhanPage({
    Key? key,
  }) : super(key: key);

  @override
  State<keluhanPage> createState() => _keluhanPageState();
}

class _keluhanPageState extends State<keluhanPage> {
  _keluhanPageState({
    Key? key,
  });

  int _currentIndex = 0;
  String _currentMenu = 'Home';
  final ImagePicker picker = ImagePicker();
  TextEditingController deskripsi = new TextEditingController();
  TextEditingController nama = new TextEditingController();
  TextEditingController telepon = new TextEditingController();
  XFile? image1;
  List? data = [];
  DateTime _tanggalLahir = DateTime.now();

  Future sendImage(ImageSource media, String nomorTelepon, String deskripsi,
      String nama) async {
    var img = await picker.pickImage(source: media);
    var uri = "http://10.1.12.49/project/APISimatukang/api/Keluhan";
    // var uri = "https://wifitermurah.com/APIOerLens/ProsesOer";
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.fields.addAll(
        {'nomorTelepon': nomorTelepon, 'keluhan': deskripsi, 'nama': nama});

    if (img != null) {
      var pic = await http.MultipartFile.fromPath("gambar1", img.path);
      request.files.add(pic);
      await request.send().then((result) {
        http.Response.fromStream(result).then((response) {
          var message = jsonDecode(response.body);
          // show snackbar if input data successfully
          if (response.statusCode == 200) {
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
              title: 'Penyampaian Berhasil',
              desc: message['messages'].toString() +
                  'Silahkan Login terlebih dahulu untuk mendapatkan notifikasi selanjutnya',
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
              title: 'Penyampaian Gagal',
              desc: message['messages'].toString(),
              showCloseIcon: true,
              btnCancelOnPress: () {},
              btnOkOnPress: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => LoginPage()),
                // );
              },
            ).show();
            return "Success!";
          }
          // setState(() {
          //   image = img;
          //   Red = message['data']['red'].toString();
          //   Green = message['data']['green'].toString();
          //   Blue = message['data']['blue'].toString();
          //   Oer = message['data']['oer'].toString();
          // });
        });
      }).catchError((e) {
        print(e);
      });
    } else {
      final snackBar = SnackBar(content: Text("Gagal Upload Gambar"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future getImage1(ImageSource media) async {
    var img1 = await picker.pickImage(source: media);
    setState(() {
      image1 = img1;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void _changeSelectedNavBar(int index) {
    setState(() {
      _currentIndex = index;

      if (index == 0) {
        _currentMenu = 'Beranda';
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => HomePage(
        //             hakAkses: hakAkses,
        //             token: token,
        //             userId: userId,
        //             index: 0,
        //           )),
        // );
      } else if (index == 1) {
        _currentMenu = 'Riwayat';
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => RiwayatPage(
        //             hakAkses: hakAkses,
        //             token: token,
        //             userId: userId,
        //             index: 1,
        //           )),
        // );
      } else if (index == 2) {
        _currentMenu = 'Permohonan';
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => ProfilePage(
        //             hakAkses: hakAkses,
        //             token: token,
        //             userId: userId,
        //             index: 2,
        //           )),
        // );
      } else if (index == 3) {
        _currentMenu = 'Profile';
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => ProfilePage(
        //             hakAkses: hakAkses,
        //             token: token,
        //             userId: userId,
        //             index: 2,
        //           )),
        // );
      }
    });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Silahkan Pilih Gambar'),
            content: Container(
              height: MediaQuery.of(context).size.height / 15,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // getImage1(ImageSource.gallery);
                      sendImage(ImageSource.gallery, telepon.text,
                          deskripsi.text, nama.text);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text(' Upload Gambar 1'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //pemanggilan material
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 202, 0, 1),
          leading: IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Keluhan",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          )),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[],
            ),
          ),
          Container(
              padding: EdgeInsets.all(10),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Container(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Deskripsi Masalah",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        "Jelaskan masalah yang ingin diselesaikan secara jelas dan detail",
                        style: TextStyle(fontSize: 18),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 10),
                                  TextFormField(
                                    maxLines: 4,
                                    controller: deskripsi,
                                    keyboardType: TextInputType.text,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Masukkan Desktripsi Masalah',
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            width: 3,
                                            color:
                                                Color.fromRGBO(255, 202, 0, 1)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: nama,
                                    keyboardType: TextInputType.text,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Masukkan Nama',
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            width: 3,
                                            color:
                                                Color.fromRGBO(255, 202, 0, 1)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    controller: telepon,
                                    keyboardType: TextInputType.text,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Masukkan Nomor Telepon',
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 10.0, 20.0, 10.0),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            width: 3,
                                            color:
                                                Color.fromRGBO(255, 202, 0, 1)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "Masukkan Gambar Permasalahan",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                myAlert();
                              },
                              child: Text('Upload Photo'),
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromRGBO(1255, 202, 0, 1)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                  // SizedBox(
                  //   height: 30,
                  // ),
                ),
              ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(255, 202, 0, 1),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Permohonan'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Color.fromRGBO(0, 0, 0, 1),
        onTap: _changeSelectedNavBar,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
