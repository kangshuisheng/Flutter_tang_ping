import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:tang_ping/Widgets/AppbarTitle.dart';
import 'package:tang_ping/Widgets/SearchBox.dart';
import 'package:tang_ping/utils/TextColor.dart';

class CirclesPage extends StatefulWidget {
  CirclesPage({Key key}) : super(key: key);

  @override
  _CirclesPageState createState() => _CirclesPageState();
}

class _CirclesPageState extends State<CirclesPage> {
  int _pageNum = 0;
  EasyRefreshController _controller;
  Map _firstCircleClassify;
  List _circleClassify;
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _circleClassify = [
      {'title': '数码圈', 'icon': 'https:', 'link': 'aaa'},
      {
        'title': '美衣圈',
        'icon':
            'https://i0.hdslb.com/bfs/sycp/creative_img/202011/ebf3554e848e9eed401c398b65eb3d53.jpg@412w_232h_1c',
        'link': 'aaa'
      },
      {
        'title': '技术宅',
        'icon':
            'https://i0.hdslb.com/bfs/sycp/creative_img/202011/ebf3554e848e9eed401c398b65eb3d53.jpg@412w_232h_1c',
        'link': 'aaa'
      },
      {
        'title': '每日口语',
        'icon':
            'https://i0.hdslb.com/bfs/sycp/creative_img/202011/ebf3554e848e9eed401c398b65eb3d53.jpg@412w_232h_1c',
        'link': 'aaa'
      },
      {
        'title': '沙雕聚集地',
        'icon':
            'https://i0.hdslb.com/bfs/sycp/creative_img/202011/ebf3554e848e9eed401c398b65eb3d53.jpg@412w_232h_1c',
        'link': 'aaa'
      },
    ];
    _firstCircleClassify = _circleClassify.removeAt(0);
    print(_circleClassify);
  }

  Widget _hasJoined(joincirclesNum) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '已加入',
            style: TextStyle(
                color: TextColor.textPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          Container(
            height: 130,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                    joincirclesNum,
                    (i) => Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  'https://i0.hdslb.com/bfs/archive/fcbc618b2bc83cb10e99b1257d9d639044fa46de.jpg@412w_232h_1c',
                                  width: 50,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Text('数码爱好者'),
                              Text(
                                '3条更新',
                                style: TextStyle(
                                    color: TextColor.textSecondaryColor),
                              )
                            ],
                          ),
                        ))),
          )
        ],
      ),
    );
  }

  Widget _cicleClassify() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '圈子分类',
          style: TextStyle(
              color: TextColor.textPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        Container(
            height: 100,
            child: Row(
              children: [
                Container(
                  width: 100,
                  child: Row(
                    children: [
                      Column(
                        children: [Text('${_firstCircleClassify['title']}')],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Text('${_firstCircleClassify['icon']}')],
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  height: 100,
                  child: GridView(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.75,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5),
                    children: List.generate(_circleClassify.length, (i) {
                      var item = _circleClassify[i];
                      return Container(
                        alignment: Alignment.center,
                        color: Colors.black45,
                        child: Text('${item['title']}'),
                      );
                    }),
                  ),
                ))
              ],
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(250, 250, 250, .9),
            elevation: 0,
            title: AppbarTitle(
              widget: Text(
                '圈子',
                style: TextStyle(
                    color: TextColor.textPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),
              icon: Icon(
                Icons.add_circle_outline,
                size: 30,
                color: Colors.black38,
              ),
              callback: () {},
            )),
        body: EasyRefresh(
            controller: _controller,
            enableControlFinishRefresh: false,
            enableControlFinishLoad: true,
            header: ClassicalHeader(),
            footer: ClassicalFooter(),
            onRefresh: () async {
              setState(() {
                _pageNum = 0;
              });
              await Future.delayed(Duration(seconds: 2), () {
                print('onRefresh');
                _controller.resetLoadState();
              });
            },
            onLoad: () async {
              setState(() {
                _pageNum++;
              });
              await Future.delayed(Duration(seconds: 2), () {
                print('onLoad');
                _controller.finishLoad(noMore: _pageNum >= 20);
              });
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Column(
                  children: [
                    buildSearchBox(context),
                    _hasJoined(5),
                    _cicleClassify()
                  ],
                ),
              ),
            )));
  }
}
