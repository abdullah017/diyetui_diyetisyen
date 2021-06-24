import 'package:fitdiyet_diyetisyen/Models/randevu_danisan.dart';
import 'package:flutter/material.dart';

class DanisanCard extends StatelessWidget {
  final RandevuDanisan danisan;
  DanisanCard({this.danisan});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(left: 18.0, bottom: 2.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        width: 150.0,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 12.0),
            Text(danisan.danisanAdi,
                overflow: TextOverflow.clip,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: theme.textTheme.subtitle1),
            SizedBox(height: 6.0),
            Text(danisan.tarih.toString().substring(0, 10),
                overflow: TextOverflow.clip,
                maxLines: 5,
                textAlign: TextAlign.center,
                style: theme.textTheme.subtitle2),
          ],
        ),
      ),
    );
  }
}
