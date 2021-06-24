// To parse this JSON data, do
//
//     final randevuDanisan = randevuDanisanFromJson(jsonString);

import 'dart:convert';

List<RandevuDanisan> randevuDanisanFromJson(String str) => List<RandevuDanisan>.from(json.decode(str).map((x) => RandevuDanisan.fromJson(x)));

String randevuDanisanToJson(List<RandevuDanisan> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RandevuDanisan {
    RandevuDanisan({
        this.id,
        this.tarih,
        this.saat,
        this.goruldu,
        this.danisanId,
        this.diyetisyenId,
        this.danisanAdi,
    });

    int id;
    DateTime tarih;
    String saat;
    dynamic goruldu;
    String danisanId;
    String diyetisyenId;
    String danisanAdi;

    factory RandevuDanisan.fromJson(Map<String, dynamic> json) => RandevuDanisan(
        id: json["id"],
        tarih: DateTime.parse(json["tarih"]),
        saat: json["saat"],
        goruldu: json["goruldu"],
        danisanId: json["danisan_id"],
        diyetisyenId: json["diyetisyen_id"],
        danisanAdi: json["danisan_adi"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tarih": "${tarih.year.toString().padLeft(4, '0')}-${tarih.month.toString().padLeft(2, '0')}-${tarih.day.toString().padLeft(2, '0')}",
        "saat": saat,
        "goruldu": goruldu,
        "danisan_id": danisanId,
        "diyetisyen_id": diyetisyenId,
        "danisan_adi": danisanAdi,
    };
}
