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
      this.postsPreviewImgCount,
      this.postsPreviewImgs,
      this.topic,
      this.circleName,
      this.joinCircleNum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Image.network(''),
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
          Container(
            child: Text('话题: $topic'),
          ),
          Row(
            children: List.generate(postsPreviewImgs.length, (index) {
              var item = postsPreviewImgs[index];
              if (index >= 3) {
                return null;
              } else {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network('$item'),
                );
              }
            }),
          )
        ],
      ),
    );
  }
}
