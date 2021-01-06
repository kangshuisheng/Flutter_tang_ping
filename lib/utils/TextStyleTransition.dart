import 'package:flutter/cupertino.dart';
import 'package:tang_ping/utils/TextColor.dart';

AnimatedDefaultTextStyle buildAnimatedDefaultTextStyle(
    Text textWidegt, int currentindex, int targetIndex) {
  return AnimatedDefaultTextStyle(
    ///每当样式有改变时会以动画的方式过渡切换
    style: currentindex == targetIndex
        ? TextStyle(
            color: TextColor.textPrimaryColor, fontWeight: FontWeight.bold)
        : TextStyle(color: TextColor.textSecondaryColor, fontWeight: null),

    ///动画切换的时间
    duration: const Duration(milliseconds: 200),

    ///动画执行插值器
    curve: Curves.bounceInOut,

    ///文本对齐方式
    textAlign: TextAlign.start,

    ///文本是否应该在软换行符处换行
    softWrap: true,

    ///超过文本行数区域的裁剪方式
    ///设置设置为省略号
    overflow: TextOverflow.ellipsis,

    ///最大显示行数
    maxLines: 1,

    ///每当样式有修改触发动画时
    ///动画执行结束的回调
    onEnd: () {},

    ///文本组件
    child: textWidegt,
  );
}
