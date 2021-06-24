import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const baseUrl = "https://www.fitdiyet.online/api/";

var token;

class DanisanService {
  static upload(
    File imageFile,
    String adTxt,
    soyadTxt,
    tcTxt,
    telefonTxt,
    yasTxt,
    kategoriTxt,
    hakkimdaTxt,
    cinsiyetTxt,
  ) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String fileName = imageFile.path.split("/").last;
    var stream = new http.ByteStream(imageFile.openRead());
    stream.cast();
    var length = await imageFile.length();

    var url =
        baseUrl + "diyetisyenler/update?token=" + localStorage.get("token");

    var request = new http.MultipartRequest("POST", Uri.parse(url))
      ..fields['adi'] = adTxt
      ..fields['soyad'] = soyadTxt
      ..fields['tc'] = tcTxt
      ..fields['telefon'] = telefonTxt
      ..fields['yas'] = yasTxt
      ..fields['kategori'] = kategoriTxt
      ..fields['hakkimda'] = hakkimdaTxt
      ..fields['cinsiyet'] = cinsiyetTxt;
    var multipartFile =
        new http.MultipartFile('image', stream, length, filename: fileName);

    request.files.add(multipartFile);
    var response = await request.send();
    if (response.statusCode == 200) {
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    }
  }

  static Future getProfile() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var url = baseUrl +
        "danisanlar/" +
        localStorage.get("id") +
        "?" +
        "token=" +
        localStorage.get("token");
    return http
        .get(
      Uri.parse(url),
    )
        .catchError((error, stackTrace) {
      print("inner: $error");
    });
  }

  static Future postRandevuAyar(String saat, tarih) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var url = baseUrl + "saat/insert?token=" + localStorage.get("token");
    var map = new Map<String, dynamic>();
    map['saat'] = saat;
    map['tarih'] = tarih;
    map['diyetisyen_id'] = localStorage.get("id");

    http.Response response = await http
        .post(
      Uri.parse(url),
      body: map,
    )
        .catchError((e) {
      print(e);
    });
    print(response.body);
  }

  static randevuData(data, apiUrl) async {
    try {
      var fullUrl = baseUrl + apiUrl;
      return await http.post(Uri.parse(fullUrl));
    } catch (e) {
      print(e);
      HttpException(e);
    }
  }
}
