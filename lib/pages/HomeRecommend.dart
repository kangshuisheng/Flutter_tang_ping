import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:tang_ping/Widgets/SearchBox.dart';
import 'package:tang_ping/utils/Http.dart';
import 'package:tang_ping/utils/PlaceHolderImg_page.dart';
import 'package:tang_ping/utils/TextColor.dart';

class HomeRecommend extends StatefulWidget {
  HomeRecommend({Key key, this.porps}) : super(key: key);
  final Map porps;
  @override
  _HomeRecommendState createState() => _HomeRecommendState();
}

class _HomeRecommendState extends State<HomeRecommend>
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
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _imgList.length,
                  itemBuilder: (context, i) {
                    var item = _imgList[i]['item'];
                    var user = _imgList[i]['user'];
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
                                  maxHeight:
                                      MediaQuery.of(context).size.height / 1.5),
                              child: Swiper(
                                loop: false,
                                itemCount: item['pictures'].length,
                                control: SwiperControl(color: Colors.white),
                                onIndexChanged: (i) {},
                                itemBuilder: (context, index) {
                                  return ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: ImageWidgetPlaceholder(
                                        imgUrl:
                                            '${item['pictures'][index]['img_src']}',
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
                                color: TextColor.textPrimaryColor,
                                fontSize: 16),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '说点什么...',
                                            style: TextStyle(
                                                color: TextColor
                                                    .textSecondaryColor),
                                          ),
                                          Icon(Icons.ac_unit,
                                              color:
                                                  TextColor.textSecondaryColor)
                                        ],
                                      ))),
                              SizedBox(
                                width: 40,
                              ),
                              Icon(Icons.lens,
                                  color: TextColor.textSecondaryColor)
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
