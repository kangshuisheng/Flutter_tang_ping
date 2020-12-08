import 'package:flutter/material.dart';
import 'package:tang_ping/utils/TextColor.dart';

class CircleDetail extends StatefulWidget {
  CircleDetail({Key key}) : super(key: key);

  @override
  _CircleDetailState createState() => _CircleDetailState();
}

class _CircleDetailState extends State<CircleDetail> {
  List<UserInfoModel> _lsit = [];
  void add() {
    UserInfoModel item = UserInfoModel(id: 100, psw: '1111', name: 'kss');
    print(item);
    _lsit.add(item);
    print(_lsit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 250, 250, .1),
        iconTheme: IconThemeData(),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.share),
          )
        ],
        title: Text(
          '数码爱好者',
          style: TextStyle(
              color: TextColor.textPrimaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black,
        child: Text('hello'),
      ),
    );
  }
}

class UserInfoModel {
  UserInfoModel({this.id, this.psw, this.name});
  int id;
  dynamic psw;
  String name;
}
