import 'package:flutter/material.dart';
import 'package:tang_ping/utils/TextColor.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<Map> _messageClassify = [
    {'title': '系统通知', 'icon': null, 'msg': '暂无'},
    {'title': '赞和收藏', 'icon': null, 'msg': '暂无'},
    {'title': '评论和@', 'icon': null, 'msg': '暂无'},
    {'title': '躺平服务区', 'icon': null, 'msg': '暂无'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 250, 250, .9),
        elevation: 0,
        title: Text(
          '消息',
          style: TextStyle(
              color: TextColor.textPrimaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(14),
        child: Column(
          children: List.generate(
              _messageClassify.length,
              (i) => Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        Column(
                          children: [Icon(Icons.ac_unit)],
                        ),
                        SizedBox(
                          width: 14,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_messageClassify[i]['title']}',
                              style: TextStyle(
                                  color: TextColor.textPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${_messageClassify[i]['msg']}',
                              style: TextStyle(
                                color: TextColor.textSecondaryColor,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
        ),
      ),
    );
  }
}
