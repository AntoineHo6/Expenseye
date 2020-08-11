import 'dart:io';

class AdMobService {
  String getAdMobAppId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1444794986567384~9428228539'; // TODO: dont make it hardcoded
    } else {
      // is IOS
    }
  }

  String getBannerAdId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1444794986567384/6667275772'; // TODO: dont make it hardcoded
    } else {
      // is IOS
    }
  }
}
