import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppbarTitle extends StatelessWidget {
  final Widget widget;
  final Function callback;
  final Icon icon;
  const AppbarTitle(
      {Key? key,
      required this.widget,
      required this.callback,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                    image: NetworkImage(
                        'https://th.wallhaven.cc/small/vg/vg7lv3.jpg'),
                    fit: BoxFit.cover)),
          ),
          widget,
          GestureDetector(
              onTap: () {
                callback();
              },
              child: icon)
        ],
      ),
    );
  }
}
