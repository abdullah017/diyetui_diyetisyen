
import 'package:fitdiyet_diyetisyen/Models/diyetisyen_model.dart';

import 'package:flutter/material.dart';

class CategoriesView extends StatefulWidget {
  final Diyetisyen diyetisyenModel;

  const CategoriesView({Key key, this.diyetisyenModel}) : super(key: key);
  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  initState() {
    super.initState();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'FİT DİYET',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      // body: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 0.0),
      //   child: Column(
      //     children: [
      //       Expanded(
      //         child: Container(
      //           width: double.infinity,
      //           height: 200.0,
      //           child: ListView.builder(
      //             scrollDirection: Axis.vertical,
      //             shrinkWrap: true,
      //             physics: BouncingScrollPhysics(),
      //             itemCount: diyetisyenler.length,
      //             itemBuilder: (context, index) {
      //               var diyetisyen = diyetisyenler[index];
      //               return GestureDetector(
      //                 onTap: () {
      //                   print("BURAYA ODAKLAN:${diyetisyenler[index]}");
      //                   Navigator.of(context).push(
      //                     MaterialPageRoute(
      //                       builder: (context) => DiyetisyenListViewDetail(
      //                         diyetisyen: diyetisyen,
      //                       ),
      //                     ),
      //                   );
      //                 },
      //                 child: _buildCategoriesList(
      //                   diyetisyenler[index],
      //                 ),
      //               );
      //             },
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }


}
