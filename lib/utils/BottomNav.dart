import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:tang_ping/pages/Tabs/Circles.dart';
import 'package:tang_ping/pages/Tabs/Create.dart';
import 'package:tang_ping/pages/Tabs/Home.dart';
import 'package:tang_ping/pages/Tabs/Message.dart';
import 'package:tang_ping/pages/Tabs/Mine.dart';
import 'package:tang_ping/utils/AnimationRoute.dart';
import 'package:tang_ping/utils/TextColor.dart';

class BottomNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BottomNavState();
  }
}

class BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  // List _currentPage = [HomePage(), MinePage()];
  List _navItem = [
    {'icon': Icons.home, 'title': '首页'},
    {'icon': Icons.adjust, 'title': '圈子'},
    {'icon': Icons.add_circle, 'title': ''},
    {'icon': Icons.message, 'title': '消息'},
    {'icon': Icons.person, 'title': '我的'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(index: _currentIndex, children: [
          HomePage(),
          CirclesPage(),
          MessagePage(),
          Container(),
          MinePage(),
        ]),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(5, (i) {
                return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (i == 2) {
                        Navigator.push(
                            context, RotationTransitionRoute(CreatePage()));
                        return;
                      }
                      setState(() {
                        _currentIndex = i;
                      });
                    },
                    child: TweenAnimationBuilder(
                      tween: Tween(
                          begin: _currentIndex == i ? 20.0 : 10.0,
                          end: _currentIndex == i ? 25.0 : 22.0),
                      duration: Duration(milliseconds: 250),
                      builder: (context, value, child) => Container(
                        height: 50,
                        width: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _navItem[i]['icon'],
                              color: i == _currentIndex
                                  ? TextColor.textPrimaryColor
                                  : TextColor.textSecondaryColor,
                              size: value,
                            ),
                            _navItem[i]['title'].length > 0
                                ? Text(
                                    _navItem[i]['title'],
                                    style: TextStyle(
                                        color: i == _currentIndex
                                            ? TextColor.textPrimaryColor
                                            : TextColor.textSecondaryColor),
                                  )
                                : SizedBox()
                          ],
                        ),
                      ),
                    ));
              })),
        ));
  }
}
