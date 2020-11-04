import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tang_ping/pages/Search/Search.dart';
import 'package:tang_ping/utils/AnimationRoute.dart';

Widget buildSearchBox({context}) {
  void _takePhoto() async {
    var image = await ImagePicker().getImage(source: ImageSource.camera);
  }

  return Container(
    margin: EdgeInsets.only(bottom: 15),
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: Color.fromRGBO(200, 200, 200, .2),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.push(context, SlideTransitionRoute(SearchPage()));
              },
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black38,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '搜索',
                    style: TextStyle(color: Colors.black38),
                  )
                ],
              )),
        ),
        GestureDetector(
          onTap: _takePhoto,
          child: Icon(
            Icons.camera,
            color: Colors.black38,
          ),
        )
      ],
    ),
  );
}
