import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageWidgetPlaceholder extends StatelessWidget {
  final String imgUrl;
  final Widget placeHolder;
  final double width;
  const ImageWidgetPlaceholder(
      {Key key, this.imgUrl, this.width, this.placeHolder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage(imgUrl),
      width: width ?? double.infinity,
      fit: BoxFit.cover,
      frameBuilder: (context, child, frame, wasSynchronousLoaded) {
        if (wasSynchronousLoaded) {
          return child;
        } else {
          return AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: frame != null ? child : placeHolder);
        }
      },
    );
  }
}
