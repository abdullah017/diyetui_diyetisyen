import 'dart:convert';

import 'package:fitdiyet_diyetisyen/Controllers/danisan_service.dart';
import 'package:fitdiyet_diyetisyen/Models/danisan_model.dart';
import 'package:fitdiyet_diyetisyen/Views/widgets/appbar/arrow_back_appbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DanisanProfile extends StatefulWidget {
  final int danisanId;
  const DanisanProfile({Key key, this.danisanId}) : super(key: key);

  @override
  _DanisanProfileState createState() => _DanisanProfileState();
}

class _DanisanProfileState extends State<DanisanProfile> {
  int id;

  String cinsiyet;

  Future<Users> getProfile(int id) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var url = baseUrl +
        "danisanlar/$id" +
        "?" +
        "token=" +
        localStorage.getString("token");
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Users.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          'Profil bilgilerine şuanda erişilimeyior.\nYa da kullanıcı henüz profilini tamamlamamış.');
    }
  }

  Future<Users> danisan;
  @override
  void initState() {
    super.initState();
    id = widget.danisanId;
    danisan = getProfile(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: arrowBackAppBar(context),
      body: Center(
        child: FutureBuilder<Users>(
          future: danisan,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Color(0xff654769),
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                        title: Center(
                          child: Text(
                            'Danışan Adı: ${snapshot.data.adi}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        subtitle: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Danışan Soyad: ${snapshot.data.soyad}",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data.cinsiyet == 1
                                  ? 'Cinsiyet: Kadın'
                                  : 'Cinsiyet: Erkek',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Yaş: ${snapshot.data.yas}",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Boy: ${snapshot.data.danisanBoy}",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Kilo: ${snapshot.data.danisanKilo}",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data.ilac == 1
                                  ? 'İlaç tedavisi: Evet'
                                  : 'İlaç tedavisi: Hayır',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data.kronikRahatsizlik == 1
                                  ? 'Kronik Rahatsızlık: Evet'
                                  : 'Kronik Rahatsızlık: Hayır',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              snapshot.data.alkol == 1
                                  ? 'Alkol Kullanımı: Evet'
                                  : 'Alkol Kullanımı: Hayır',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Dışarıda Tüketilen Öğün: ${snapshot.data.disariYemek}",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Günlük Tüketilen Öğün: ${snapshot.data.gunlukOgun}",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Günlük Tüketilen Su: ${snapshot.data.gunlukSu}",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Hedef Kilo: ${snapshot.data.hedefKilo}",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Sevilen Besinler: ${snapshot.data.sevilenBesin}",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Sevilmeyen Besinler: ${snapshot.data.sevilmeyenBesin}",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Diğer: ${snapshot.data.aciklama}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (snapshot.hasData == null) {
              return Text("Herhangi bir randevunuz bulunmamakta");
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
