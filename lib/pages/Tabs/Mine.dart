import 'package:flutter/material.dart';
import 'package:tang_ping/utils/TextColor.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 250, 250, .9),
        elevation: 0,
        actions: [
          Container(
            child: Text(
              'hello',
              style: TextStyle(color: TextColor.textPrimaryColor),
            ),
          )
        ],
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Image.network(''),
                Row(
                  children: [
                    Container(
                      child: Row(
                        children: [],
                      ),
                    ),
                    Container(
                      child: Text('我的'),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [],
            ),
            Row(
              children: [],
            )
          ],
        ),
      )),
    );
  }
}
