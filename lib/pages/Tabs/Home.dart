import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tang_ping/Widgets/AppbarTitle.dart';
import 'package:tang_ping/Widgets/SearchBox.dart';
import 'package:tang_ping/pages/HomeFocus.dart';
import 'package:tang_ping/pages/HomeRecommend.dart';
import 'package:tang_ping/utils/AnimationRoute.dart';
import 'package:tang_ping/utils/Http.dart';
import 'package:tang_ping/utils/PlaceHolderImg_page.dart';
import 'package:tang_ping/utils/PreviewImg.dart';
import 'package:tang_ping/utils/RandomColorContainer.dart';
import 'package:tang_ping/utils/TextColor.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;
  int _active = 0;
  int _last = 0;
  List<Map> pages = [
    {
      "title": "推荐",
    },
    {
      "title": "关注",
    }
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _active, keepPage: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // List<String> _likeIDList = []; //存放新添加的喜欢

  var _imgPath;
  /*拍照*/

  /*相册*/
  void _openGallery() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _imgPath = image;
    });
  }

  Future<bool> doubleClickBack() {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - _last > 1000) {
      BotToast.showText(text: '再按一次退出');
      _last = DateTime.now().millisecondsSinceEpoch;
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  Widget _buildTab(List arr, int i) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _active = i;
            _pageController.animateToPage(_active,
                duration: Duration(milliseconds: 350), curve: Curves.linear);
          });
        },
        child: Container(
            // margin: EdgeInsets.only(right: 10),
            child: Text(
          '${arr[i]["title"]}',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _active == i
                  ? TextColor.textPrimaryColor
                  : TextColor.textSecondaryColor),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: AppbarTitle(
                widget: Container(
                  width: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                        List.generate(pages.length, (i) => _buildTab(pages, i)),
                  ),
                ),
                icon: Icon(
                  Icons.more_horiz,
                  size: 30,
                  color: Colors.black38,
                ),
              ),
            ),
            body: PageView(
              controller: _pageController,
              onPageChanged: (i) {
                setState(() {
                  _active = i;
                });
              },
              children: [HomeFocus(), HomeRecommend()],
            )),
        onWillPop: doubleClickBack);
  }
}
