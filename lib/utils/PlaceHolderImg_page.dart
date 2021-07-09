import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageWidgetPlaceholder extends StatelessWidget {
  final String imgUrl;
  final Widget placeHolder;
  final double? width;
  final BoxFit fit;
  const ImageWidgetPlaceholder(
      {Key? key,
      required this.fit,
      required this.imgUrl,
      this.width,
      required this.placeHolder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage(imgUrl),
      width: width ?? double.infinity,
      fit: fit,
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
