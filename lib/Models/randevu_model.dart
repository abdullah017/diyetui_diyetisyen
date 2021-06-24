// To parse this JSON data, do
//
//     final randevu = randevuFromJson(jsonString);

import 'dart:convert';

List<Randevu> randevuFromJson(String str) => List<Randevu>.from(json.decode(str).map((x) => Randevu.fromJson(x)));

String randevuToJson(List<Randevu> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Randevu {
    Randevu({
        this.id,
        this.tarih,
        this.saat,
        this.goruldu,
        this.danisanId,
        this.diyetisyenId,
        this.danisanAdi,
    });

    int id;
    String tarih;
    String saat;
    dynamic goruldu;
    String danisanId;
    String diyetisyenId;
    dynamic danisanAdi;

    factory Randevu.fromJson(Map<String, dynamic> json) => Randevu(
        id: json["id"],
        tarih: json["tarih"],
        saat:json["saat"],
        goruldu: json["goruldu"],
        danisanId: json["danisan_id"],
        diyetisyenId: json["diyetisyen_id"],
        danisanAdi: json["danisan_adi"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tarih":tarih,
        "saat": saat,
        "goruldu": goruldu,
        "danisan_id": danisanId,
        "diyetisyen_id": diyetisyenId,
        "danisan_adi": danisanAdi,
    };
}

