import 'dart:io';
class AdMobService {

  String getAdMobAppId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9512696322864709~2262496483';
    }
    return null;
  }

  String getBannerAdId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9512696322864709/8195503532';
    }
    return null;
  }
}