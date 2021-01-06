import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tang_ping/Widgets/AppbarTitle.dart';
import 'package:tang_ping/Widgets/SearchBox.dart';
import 'package:tang_ping/utils/AnimationRoute.dart';
import 'package:tang_ping/utils/Http.dart';
import 'package:tang_ping/utils/PlaceHolderImg_page.dart';
import 'package:tang_ping/utils/PreviewImg.dart';
import 'package:tang_ping/utils/RandomColorContainer.dart';
import 'package:tang_ping/utils/TextColor.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _getCosList(_pageNum);
    _controller = EasyRefreshController();
    _pageController = PageController(initialPage: _active, keepPage: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  EasyRefreshController _controller;
  PageController _pageController;
  int _pageNum = 0, _active = 0, _cosImgTotalCount = 0;
  List<dynamic> _defaultCosList = [];
  int _last = 0;

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

  void _getCosList(
    int numb,
  ) async {
    var res = await HttpUtil().get(
        'https://api.vc.bilibili.com/link_draw/v2/Photo/list?category=cos&type=hot&page_num=$numb&page_size=8');
    if (res['code'] == 0) {
      setState(() {
        _defaultCosList.addAll(res['data']['items']);
        _cosImgTotalCount = res['data']['total_count'];
      });
    }
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

  void _showBottomSheet(context, {int index, Map user}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: 200,
            child: Container(
              padding: EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _defaultCosList.removeAt(index);
                      });
                      Navigator.pop(context);
                    },
                    child: Text(
                      '不想看该图集',
                      style: TextStyle(
                          color: TextColor.textPrimaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _defaultCosList.removeWhere((element) =>
                            element['user']['name'] == user['name']);
                        Navigator.pop(context);
                      });
                    },
                    child: Text(
                      '不想看${user['name']}的投稿',
                      style: TextStyle(
                          color: TextColor.textPrimaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '调教自己',
                    style: TextStyle(
                        color: TextColor.textPrimaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text('取消',
                        style: TextStyle(
                            color: TextColor.textSecondaryColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ));
      },
    );
  }

  Widget _buildTab(List arr, int i) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _active = i;
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

  Widget _buildGridList() {
    return SingleChildScrollView(
      child: StaggeredGridView.countBuilder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        addAutomaticKeepAlives: true,
        crossAxisCount: 4,
        itemCount: _defaultCosList.length,
        itemBuilder: (BuildContext context, int index) {
          final item = _defaultCosList[index]['item'];
          final user = _defaultCosList[index]['user'];
          var imgs = [];
          for (var i = 0; i < item['pictures'].length; i++) {
            imgs.add(item['pictures'][i]['img_src']);
          }
          // print("??????????????${item['pictures'][0]['img_src']}");
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            FadeTransitionRoute(PreviewImgPage(
                              images: imgs,
                              index: 0,
                              heroTag: item['title'],
                            )));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: ImageWidgetPlaceholder(
                            key: ValueKey(item['pictures'][0]['img_src']),
                            imgUrl: item['pictures'][0]['img_src'] ??
                                'https://th.wallhaven.cc/small/vg/vg7lv3.jpg',
                            placeHolder: RandomColorCotnainer()),
                      ))),
              SizedBox(
                height: 15,
              ),
              Text(
                '${item['title']}',
                style: TextStyle(color: TextColor.textPrimaryColor),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      _showBottomSheet(context, index: index, user: user);
                    },
                    child: Icon(
                      Icons.more_horiz,
                      color: TextColor.textSecondaryColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        if (item['already_liked'] == 1) {
                          item['already_liked'] = 0;
                        } else {
                          item['already_liked'] = 1;
                        }
                      });
                    },
                    child: Icon(
                      Icons.thumb_up,
                      color: item['already_liked'] == 0
                          ? TextColor.textSecondaryColor
                          : Colors.redAccent,
                      size: 18,
                    ),
                  )
                ],
              )
            ],
          );
        },
        staggeredTileBuilder: (int index) =>
            StaggeredTile.count(2, index.isEven ? 3 : 2),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
    );
  }

  Widget _buildColumnList() {
    return SingleChildScrollView(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _defaultCosList.length,
        itemBuilder: (context, i) {
          var item = _defaultCosList[i]['item'];
          var user = _defaultCosList[i]['user'];
          return Container(
            margin: EdgeInsets.only(bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flex(
                        direction: Axis.horizontal,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: ImageWidgetPlaceholder(
                                key: ValueKey(user['head_url']),
                                imgUrl: user['head_url'],
                                width: 30,
                                placeHolder: Container(
                                  width: 30,
                                  height: 30,
                                  color: Colors.black87,
                                ),
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Text('${user['name']}')
                        ],
                      ),
                      Container(
                        child: Icon(
                          Icons.more_horiz,
                          size: 24,
                          color: Colors.black38,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 1.5),
                    child: Swiper(
                      loop: false,
                      itemCount: item['pictures'].length,
                      control: SwiperControl(color: Colors.white),
                      onIndexChanged: (i) {},
                      itemBuilder: (context, index) {
                        return ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: ImageWidgetPlaceholder(
                              imgUrl: '${item['pictures'][index]['img_src']}',
                              placeHolder: Container(
                                color: Colors.black12,
                              ),
                            ));
                      },
                    )),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '${item['title']}',
                  style: TextStyle(
                      color: TextColor.textPrimaryColor, fontSize: 16),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '说点什么...',
                                  style: TextStyle(
                                      color: TextColor.textSecondaryColor),
                                ),
                                Icon(Icons.ac_unit,
                                    color: TextColor.textSecondaryColor)
                              ],
                            ))),
                    SizedBox(
                      width: 40,
                    ),
                    Icon(Icons.lens, color: TextColor.textSecondaryColor)
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map> pages = [
      {"title": "推荐", "component": _buildGridList()},
      {"title": "关注", "component": _buildColumnList()}
    ];
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
            body: EasyRefresh(
                enableControlFinishRefresh: false,
                enableControlFinishLoad: true,
                controller: _controller,
                header: ClassicalHeader(),
                footer: ClassicalFooter(),
                onRefresh: () async {
                  setState(() {
                    _pageNum = 0;
                    _defaultCosList = [];
                  });
                  _getCosList(0);
                  await Future.delayed(Duration(seconds: 2), () {
                    print('onRefresh');
                    _controller.resetLoadState();
                  });
                },
                onLoad: () async {
                  setState(() {
                    _pageNum++;
                  });
                  _getCosList(_pageNum);
                  await Future.delayed(Duration(seconds: 2), () {
                    print('onLoad');
                    _controller.finishLoad(
                        noMore: _defaultCosList.length >= _cosImgTotalCount);
                  });
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    children: [
                      buildSearchBox(context),
                      pages[_active]["component"]
                    ],
                  ),
                ))),
        onWillPop: doubleClickBack);
  }
}
