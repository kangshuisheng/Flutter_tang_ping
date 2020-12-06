import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tang_ping/utils/TextColor.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  List _userSampleReels = ['动态', '合辑'];
  List<Map> _userFocus = [
    {'title': '关注', 'nums': 9},
    {'title': '粉丝', 'nums': 9},
    {'title': '获赞', 'nums': 9},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 250, 250, .9),
        elevation: 0,
        actions: [
          Container(
              margin: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.share,
                color: TextColor.textPrimaryColor,
              ))
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.network(
                          'https://tse1-mm.cn.bing.net/th?id=OIP.DH-sl0dYREvLnyAcBuOlnQHaLH&w=132&h=160&c=8&rs=1&qlt=90&pid=3.1&rm=2',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        )),
                    Row(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit,
                                size: 14,
                              ),
                              Text('编辑')
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          child: Text('我的'),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [Text('躺平康水生')],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: List.generate(
                      _userFocus.length,
                      (i) => Container(
                            margin: EdgeInsets.only(right: 30),
                            child: Column(
                              children: [
                                Text('${_userFocus[i]['nums']}'),
                                Text('${_userFocus[i]['title']}'),
                              ],
                            ),
                          )),
                ),
                SizedBox(
                  height: 26,
                ),
                Container(
                  height: 0.5,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 26,
                ),
                Row(
                    children: List.generate(
                        _userSampleReels.length,
                        (i) => Container(
                              margin: EdgeInsets.only(right: 30),
                              child: Text('${_userSampleReels[i]}'),
                            )))
              ],
            ),
          )),
    );
  }
}
