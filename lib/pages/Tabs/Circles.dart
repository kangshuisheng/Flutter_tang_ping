import 'package:flutter/material.dart';
import 'package:tang_ping/Widgets/SearchBox.dart';
import 'package:tang_ping/utils/TextColor.dart';

class CirclesPage extends StatefulWidget {
  CirclesPage({Key key}) : super(key: key);

  @override
  _CirclesPageState createState() => _CirclesPageState();
}

class _CirclesPageState extends State<CirclesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(250, 250, 250, .9),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1741476901,4013212021&fm=11&gp=0.jpg'))),
            ),
            Text(
              '圈子',
              style: TextStyle(
                  color: TextColor.textPrimaryColor,
                  fontWeight: FontWeight.bold),
            ),
            GestureDetector(
                onTap: () {
                  // Navigator.push(context, route)
                },
                child: Icon(
                  Icons.add_circle_outline,
                  size: 30,
                  color: Colors.black38,
                ))
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          children: [buildSearchBox(context: context)],
        ),
      ),
    );
  }
}
