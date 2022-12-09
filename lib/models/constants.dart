import 'package:twin_apps/models/appdetailmodels.dart';
import 'package:twin_apps/models/appstore.dart';
import 'package:video_player/video_player.dart';
import 'package:appinio_video_player/appinio_video_player.dart';

class Constants {
  //static int bodyIndex = 0;
  static Map<int, AppDetail> appDetails = {};
  static late VideoPlayerController controller;
  static late AppStore store;
  static late Future<void> video;
  static bool muted = true;
  static bool isWeb = true;
  static late VideoPlayerController videoPlayerController;
  static late CustomVideoPlayerWebController customVideoPlayerController;
}
