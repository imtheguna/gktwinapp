import 'package:twin_apps/controller/firebaseMag.dart';
import 'package:twin_apps/models/appdetailmodels.dart';
import 'package:twin_apps/models/devdetails.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:appinio_video_player/appinio_video_player.dart';

class AppStore extends VxStore {
  int bodyIndex = 0;
  Map<int, AppDetail> appDetails = {};
  Map<String, DevDetails> devDetails = {};
  Map<int, String> sizelist = {};
  int srcIndex = 0;
  int selectSev = 0;
  Map<String, double> offset = {};
  bool isemailsending = false;
  bool showall = false;
  // List<AppDetail> appDetails = [];
  String ProVideoLink =
      'https://firebasestorage.googleapis.com/v0/b/twin-brother.appspot.com/o/video.mp4?alt=media&token=d38ed506-b421-420f-869a-ced7cccce52a';
}

class SrcShow extends VxMutation<AppStore> {
  final bool showall;

  SrcShow(this.showall);
  @override
  perform() {
    store!.showall = showall;
  }
}

class Setoffset extends VxMutation<AppStore> {
  final double off;
  final String view;

  Setoffset(this.off, this.view);
  @override
  perform() {
    store!.offset[view] = off;
  }
}

class SetIsemail extends VxMutation<AppStore> {
  final bool isemailsending;

  SetIsemail(this.isemailsending);
  @override
  perform() {
    store!.isemailsending = isemailsending;
  }
}

class SelectSev extends VxMutation<AppStore> {
  final int selectSev;
  final AppStore store;
  SelectSev(this.selectSev, this.store);
  @override
  perform() {
    store.selectSev = selectSev;
  }
}

class SrcIndex extends VxMutation<AppStore> {
  final int srcIndex;
  final AppStore store;

  SrcIndex(this.srcIndex, this.store);
  @override
  perform() {
    store.srcIndex = srcIndex;
  }
}

class SetSize extends VxMutation<AppStore> {
  final String size;
  final int i;
  final AppStore store;

  SetSize(this.size, this.store, this.i);
  @override
  perform() {
    store.sizelist[i] = size;
    // print(store.sizelist);
  }
}

class IndexSet extends VxMutation<AppStore> {
  final int index;

  IndexSet(this.index);
  @override
  perform() {
    store!.bodyIndex = index;
  }
}

class SetApps extends VxMutation<AppStore> {
  @override
  perform() async {
    await FireStoreDataBase().getAppsData(store: AppStore()).then((value) {
      store!.appDetails = value;
      // print(value);
    });
  }
}

class SetDev extends VxMutation<AppStore> {
  @override
  perform() async {
    await FireStoreDataBase().getDevDetails(store: AppStore()).then((value) {
      store!.devDetails = value;
    });
  }
}
