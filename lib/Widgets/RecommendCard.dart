import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tang_ping/utils/TextColor.dart';

class RecommendCard extends StatelessWidget {
  final int postsPreviewImgCount; //? 预览图数量
  final List postsPreviewImgs; //? 预览图
  final String topic, circleName; //? 所属话题, 圈子名字
  final int joinCircleNum; //? 加入人数

  RecommendCard(
      {Key key,
      @required this.postsPreviewImgCount,
      @required this.postsPreviewImgs,
      @required this.topic,
      @required this.circleName,
      @required this.joinCircleNum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.network(
                        'https://th.wallhaven.cc/small/vg/vg7lv3.jpg',
                        width: 24,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    circleName,
                    style: TextStyle(
                        color: TextColor.textPrimaryColor, fontSize: 14),
                  )
                ],
              ),
              Text(
                '$joinCircleNum 人加入',
                style: TextStyle(
                    color: TextColor.textSecondaryColor, fontSize: 10),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(6)),
            child: Text(
              '话题: $topic',
              style: TextStyle(
                  color: TextColor.textPrimaryColor, fontSize: 12, height: 1),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(postsPreviewImgs.length, (index) {
              var item = postsPreviewImgs[index];
              if (index >= 3) {
                return SizedBox();
              } else {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    '$item',
                    width: 300 / 4,
                    height: 300 / 4,
                    fit: BoxFit.fill,
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
