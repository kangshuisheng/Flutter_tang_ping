import 'package:flutter/material.dart';
import 'package:tang_ping/utils/TextColor.dart';

class CreatePage extends StatefulWidget {
  CreatePage({Key key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
                    children: [Icon(Icons.image), Text('发文章')],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Text('图文'),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: Text('视频'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}