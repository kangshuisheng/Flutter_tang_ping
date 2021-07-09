import 'package:flutter/material.dart';
import 'package:tang_ping/pages/CircleDetail.dart';
import 'package:tang_ping/utils/AnimationRoute.dart';
import 'package:tang_ping/utils/TextColor.dart';

class CreatePage extends StatefulWidget {
  CreatePage({Key? key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '生活碎片波特',
              style: TextStyle(
                  color: TextColor.textSecondaryColor,
                  fontWeight: FontWeight.bold),
            ),
            Column(
              children: [
                GestureDetector(
                  child: Column(
                    children: [
                      Icon(
                        Icons.image,
                        color: TextColor.textSecondaryColor,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '发文章',
                        style: TextStyle(
                            color: TextColor.textSecondaryColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Text('图文',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Text('视频',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: 30,
                      height: 30,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40)),
                      child: Icon(
                        Icons.close,
                        size: 14,
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
