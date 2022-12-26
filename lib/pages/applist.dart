import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:twin_apps/controller/firebaseMag.dart';
import 'package:twin_apps/models/appdetailmodels.dart';
import 'package:twin_apps/models/appstore.dart';
import 'package:twin_apps/widgets/appbar_widget.dart';
import 'package:twin_apps/widgets/webapplist.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:extended_image/extended_image.dart';

class AppListview extends StatefulWidget {
  final AppStore store;
  final ValueChanged<AppStore> onTappedApp;
  final ValueChanged<AppDetail> onTapped;
  const AppListview(
      {super.key,
      required this.store,
      required this.onTapped,
      required this.onTappedApp});

  @override
  State<AppListview> createState() => _AppListviewState();
}

class _AppListviewState extends State<AppListview> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            width > 600
                ? AppBarWidget(
                    store: widget.store,
                  )
                : AppBarWidgetPhone(
                    store: widget.store,
                  ),
            width > 600
                ? Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: ApplistWeb(
                        onTapped: widget.onTapped,
                        store: widget.store,
                      ),
                    ),
                  )
                : Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Padding(
                        //   padding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
                        //   child: Text(
                        //     'All Apps from Gk',
                        //     style: TextStyle(fontSize: 20),
                        //   ),
                        // ),
                        Expanded(
                          flex: 1,
                          child: ApplistForMbile(
                            onTapped: widget.onTapped,
                            store: widget.store,
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ));
  }
}

class ApplistForMbile extends StatelessWidget {
  final AppStore store;
  final ValueChanged<AppDetail> onTapped;
  final bool isSubview;
  final int subviewid;
  const ApplistForMbile(
      {super.key,
      required this.store,
      required this.onTapped,
      this.isSubview = false,
      this.subviewid = 0});
  String getTag(List tag) {
    String tag1 = '';
    for (int i = 0; i < tag.length; i++) {
      tag1 = tag1 + "|" + tag[i];
    }
    return tag1.replaceFirst('|', '');
  }

  @override
  Widget build(BuildContext context) {
    // print(store.sizelist);
    //FireStoreDataBase().getSize(store.appDetails[2]!.dowlink);
    return Container(
      child: ListView.builder(
        itemCount: store.appDetails.length,
        itemBuilder: (_, i) {
          // print(store.sizelist[i + 1]);
          if (isSubview && subviewid == i + 1) {
            return Container();
          } else {}
          return Padding(
            padding: isSubview
                ? EdgeInsets.all(0)
                : EdgeInsets.only(left: 8, right: 8),
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onTap: () => onTapped(store.appDetails[i + 1]!),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 4.0, left: 4, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      SizedBox(
                        width: isSubview ? 0 : 10,
                      ),
                      if (!isSubview)
                        Text(
                          (i + 1).toString(),
                          style: TextStyle(fontSize: 15),
                        ),
                      const SizedBox(
                        width: 5,
                      ),
                      Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          height: 70,
                          width: 70,
                          margin: const EdgeInsets.all(6.0),
                          child: ExtendedImage.network(
                            store.appDetails[i + 1]!.logo,
                            enableLoadState: true,
                            //shape: BoxShape.circle,
                            fit: BoxFit.contain,
                            cache: true,
                            loadStateChanged: (ExtendedImageState state) {
                              switch (state.extendedImageLoadState) {
                                case LoadState.failed:
                                  state.reLoadImage();
                                  break;
                                case LoadState.loading:
                                  break;
                                case LoadState.completed:
                                  if (state.wasSynchronouslyLoaded) {
                                    return state.completedWidget;
                                  }
                                  break;
                              }
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 4, right: 12, left: 8),
                              child: Container(
                                padding: const EdgeInsets.only(right: 12),
                                child: Text(
                                  store.appDetails[i + 1]!.name,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 4, right: 12, left: 8),
                              child: Container(
                                padding: const EdgeInsets.only(right: 12),
                                child: Text(
                                  getTag(store.appDetails[i + 1]!.tag),
                                  maxLines: 2,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 13,
                                      color: Colors.black45),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 4, right: 12, left: 8),
                              child: Container(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Text(
                                    store.appDetails[i + 1]!.size,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 13,
                                        color: Colors.black45),
                                  )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
