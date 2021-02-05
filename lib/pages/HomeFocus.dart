import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tang_ping/Widgets/SearchBox.dart';
import 'package:tang_ping/utils/AnimationRoute.dart';
import 'package:tang_ping/utils/Http.dart';
import 'package:tang_ping/utils/PlaceHolderImg_page.dart';
import 'package:tang_ping/utils/PreviewImg.dart';
import 'package:tang_ping/utils/RandomColorContainer.dart';
import 'package:tang_ping/utils/TextColor.dart';

class HomeFocus extends StatefulWidget {
  HomeFocus({Key key, this.props}) : super(key: key);
  final Map props;
  @override
  _HomeFocusState createState() => _HomeFocusState();
}

class _HomeFocusState extends State<HomeFocus>
    with AutomaticKeepAliveClientMixin {
  EasyRefreshController _controller = EasyRefreshController();
  int _pageNum = 0;
  List _imgList = [];
  int _imgCount;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getCosList(_pageNum);
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
                        _imgList.removeAt(index);
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
                        _imgList.removeWhere((element) =>
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

  void _getCosList(
    int numb,
  ) async {
    var res = await HttpUtil().get(
        'https://api.vc.bilibili.com/link_draw/v2/Photo/list?category=cos&type=hot&page_num=$numb&page_size=8');
    if (res['code'] == 0) {
      if (mounted) {
        setState(() {
          _imgList.addAll(res['data']['items']);
          _imgCount = res['data']['total_count'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
        enableControlFinishRefresh: false,
        enableControlFinishLoad: true,
        controller: _controller,
        header: ClassicalHeader(),
        footer: ClassicalFooter(),
        onRefresh: () async {
          setState(() {
            _pageNum = 0;
            _imgList.clear();
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
            _controller.finishLoad(noMore: _imgList.length >= _imgCount);
          });
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              buildSearchBox(context),
              SingleChildScrollView(
                child: StaggeredGridView.countBuilder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  addAutomaticKeepAlives: true,
                  crossAxisCount: 4,
                  itemCount: _imgList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = _imgList[index]['item'];
                    final user = _imgList[index]['user'];
                    var imgs = [];
                    for (var i = 0; i < item['pictures'].length; i++) {
                      imgs.add(item['pictures'][i]['img_src']);
                    }
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
                                      fit: BoxFit.cover,
                                      key: ValueKey(
                                          item['pictures'][0]['img_src']),
                                      imgUrl: item['pictures'][0]['img_src'] ??
                                          'https://th.wallhaven.cc/small/vg/vg7lv3.jpg',
                                      placeHolder: RandomColorCotnainer()),
                                ))),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${item['title']}',
                          style: TextStyle(
                              color: TextColor.textPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showBottomSheet(context,
                                    index: index, user: user);
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
              )
            ],
          ),
        ));
  }
}
