import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

// ignore: must_be_immutable
class PreviewImgPage extends StatefulWidget {
  List images = [];
  int index = 0;
  String heroTag;
  PageController controller;

  PreviewImgPage(
      {Key key,
      @required this.images,
      this.index,
      this.controller,
      this.heroTag})
      : super(key: key) {
    controller = PageController(initialPage: index);
  }

  @override
  _PreviewImgPageState createState() => _PreviewImgPageState();
}

class _PreviewImgPageState extends State<PreviewImgPage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
                color: Colors.black,
                child: PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(widget.images[index]),
                      heroAttributes: widget.heroTag.isNotEmpty
                          ? PhotoViewHeroAttributes(tag: widget.heroTag)
                          : null,
                    );
                  },
                  itemCount: widget.images.length,
                  loadFailedChild: Container(
                    child: Text('加载中'),
                  ),
                  loadingBuilder: (context, event) => Container(
                    child: Text('加载中'),
                  ),
                  backgroundDecoration: null,
                  pageController: widget.controller,
                  enableRotation: true,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                )),
          ),
          Positioned(
            //图片index显示
            top: MediaQuery.of(context).padding.top + 15,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text("${currentIndex + 1}/${widget.images.length}",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
          Positioned(
            //右上角关闭按钮
            right: 10,
            top: MediaQuery.of(context).padding.top,
            child: IconButton(
              icon: Icon(
                Icons.close,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
