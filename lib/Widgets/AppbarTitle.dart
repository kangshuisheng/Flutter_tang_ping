import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppbarTitle extends StatelessWidget {
  final Widget widget;
  final Function callback;
  final Icon icon;
  const AppbarTitle({Key key, this.widget, this.callback, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
        widget,
        GestureDetector(
            onTap: () {
              callback();
            },
            child: icon)
      ],
    );
  }
}
