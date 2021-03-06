import 'package:flutter/material.dart';

class FadeTransitionRoute extends PageRouteBuilder {
  final Widget widget;

  FadeTransitionRoute(this.widget)
      : super(
            transitionDuration: Duration(milliseconds: 350),
            pageBuilder: (
              BuildContext context,
              Animation<double> animaton1,
              Animation<double> animaton2,
            ) {
              return widget;
            },
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animaton1,
              Animation<double> animaton2,
              Widget child,
            ) {
              // 渐变效果
              return FadeTransition(
                // 从0开始到1
                opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  // 传入设置的动画
                  parent: animaton1,
                  // 设置效果，快进漫出   这里有很多内置的效果
                  curve: Curves.fastOutSlowIn,
                )),
                child: child,
              );
            });
}

class ScaleTransitionRoute extends PageRouteBuilder {
  final Widget widget;

  ScaleTransitionRoute(this.widget)
      : super(
            // 设置过度时间
            transitionDuration: Duration(milliseconds: 350),
            // 构造器
            pageBuilder: (
              // 上下文和动画
              BuildContext context,
              Animation<double> animaton1,
              Animation<double> animaton2,
            ) {
              return widget;
            },
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animaton1,
              Animation<double> animaton2,
              Widget child,
            ) {
              return ScaleTransition(
                scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                    parent: animaton1, curve: Curves.fastOutSlowIn)),
                child: child,
              );
            });
}

class RotationTransitionRoute extends PageRouteBuilder {
  final Widget widget;

  RotationTransitionRoute(this.widget)
      : super(
            // 设置过度时间
            transitionDuration: Duration(milliseconds: 350),
            // 构造器
            pageBuilder: (
              // 上下文和动画
              BuildContext context,
              Animation<double> animaton1,
              Animation<double> animaton2,
            ) {
              return widget;
            },
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animaton1,
              Animation<double> animaton2,
              Widget child,
            ) {
              // 旋转加缩放动画效果
              return RotationTransition(
                // alignment: Alignment.bottomCenter,
                turns: Tween(begin: 0.0, end: 0.0).animate(CurvedAnimation(
                  parent: animaton1,
                  curve: Curves.fastOutSlowIn,
                )),
                child: ScaleTransition(
                  alignment: Alignment.bottomCenter,
                  scale: Tween(begin: 0.1, end: 1.0).animate(CurvedAnimation(
                      parent: animaton1, curve: Curves.linearToEaseOut)),
                  child: child,
                ),
              );
            });
}

class SlideTransitionRoute extends PageRouteBuilder {
  final Widget widget;

  SlideTransitionRoute(this.widget)
      : super(
            // 设置过度时间
            transitionDuration: Duration(milliseconds: 350),
            // 构造器
            pageBuilder: (
              // 上下文和动画
              BuildContext context,
              Animation<double> animaton1,
              Animation<double> animaton2,
            ) {
              return widget;
            },
            transitionsBuilder: (
              BuildContext context,
              Animation<double> animaton1,
              Animation<double> animaton2,
              Widget child,
            ) {
              // 左右滑动动画效果
              return SlideTransition(
                position: Tween<Offset>(
                        // 设置滑动的 X , Y 轴
                        begin: Offset(1.0, 0.0),
                        end: Offset(0.0, 0.0))
                    .animate(CurvedAnimation(
                        parent: animaton1, curve: Curves.fastOutSlowIn)),
                child: child,
              );
            });
}
