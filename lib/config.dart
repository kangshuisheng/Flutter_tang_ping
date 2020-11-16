import 'package:bot_toast/bot_toast.dart';

class Config {
  static Future<bool> doubleClickBack() {
    int now = DateTime.now().millisecondsSinceEpoch;
    int _last = 0;
    if (now - _last > 1000) {
      BotToast.showText(text: '再按一次退出');
      _last = DateTime.now().millisecondsSinceEpoch;
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}