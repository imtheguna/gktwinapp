import 'package:extended_image/extended_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:twin_apps/controller/firebaseMag.dart';
import 'package:twin_apps/controller/showModalbottomSheet.dart';

import 'package:twin_apps/widgets/appbar_widget.dart';

import 'package:flutter/material.dart';
import 'package:twin_apps/controller/downloadercontroller.dart';
import 'package:twin_apps/models/appdetailmodels.dart';
import 'package:twin_apps/models/appstore.dart';
import 'package:twin_apps/pages/appviewweb.dart';

class AppViewMobile extends StatelessWidget {
  final AppDetail app;
  final Map<String, dynamic> dev;
  final AppStore store;
  const AppViewMobile(
      {super.key, required this.app, required this.dev, required this.store});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    double width = MediaQuery.of(context).size.width;
    String disp = app.description.replaceAll('\\n', '\n');
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            width > 600
                ? AppBarWidget(
                    store: store,
                  )
                : AppBarWidgetPhone(
                    store: store,
                  ),
            MobileAppDetails(
              app: app,
              store: store,
            ),
            const SizedBox(
              height: 15,
            ),
            ImageViewMobile(
              app: app,
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'About this app',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                //height: 50,
                child: SizedBox(
                  width: double.infinity,
                  child: SelectableText(
                    disp,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black54),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'What\'s new',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 4,
              width: width,
            ),
            SizedBox(
              width: width,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SelectableText(
                  app.new_update_details,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ),
            ),
            SizedBox(
              height: 13,
              width: width / 2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 5),
              child: SizedBox(
                height: 30,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: app.tag.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 4, left: 0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 208, 208, 208)),
                          color: Colors.white,
                          //  border: BoxBorder.lerp(a, b, t),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 4,
                            bottom: 4,
                            left: 8,
                            right: 10,
                          ),
                          child: Center(
                              child: Text(
                            app.tag[index],
                            style: const TextStyle(
                                color: Colors.black38, fontSize: 13),
                          )),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 13,
              width: width / 2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Developer contact',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                    width: double.infinity,
                  ),
                  InkWell(
                    onTap: () => DownloadController()
                        .launchUrls(Uri.parse(dev['website']), -1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      width: 450,
                      child: ListTile(
                        leading: const Icon(Icons.wb_cloudy_outlined),
                        title: const Text('Website'),
                        subtitle: Text(dev['website']),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => DownloadController()
                        .launchUrls(Uri.parse("mailto:" + dev['email']), -1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      width: 450,
                      child: ListTile(
                        leading: const Icon(Icons.email_outlined),
                        title: const Text('Email'),
                        subtitle: Text(dev['email']),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      ShowModalBottomSheet().modalBottomSheetMenu(
                          context: context,
                          height: 480,
                          width: width,
                          isweb: false,
                          t2: dev['Information'],
                          t1: dev['Privacy'],
                          t3: dev['Contact_de']);
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      width: 450,
                      child: ListTile(
                        leading: const Icon(Icons.privacy_tip_outlined),
                        title: const Text('Privacy Policy'),
                        subtitle: Text(dev['policy_link']),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MobileAppDetails extends StatefulWidget {
  final AppDetail app;

  final AppStore store;
  const MobileAppDetails({super.key, required this.app, required this.store});

  @override
  State<MobileAppDetails> createState() => _MobileAppDetailsState();
}

class _MobileAppDetailsState extends State<MobileAppDetails> {
  int count = 0;

  getcount() {
    FireStoreDataBase().getCOunt(id: widget.app.id).then(
      (value) {
        count = value;
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    getcount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10, top: 10),
              child: Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ExtendedImage.network(
                        widget.app.logo,
                        enableLoadState: true,
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
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.app.name,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    widget.app.ads == true ? 'Contains ads' : 'No ads',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        "$count Downloads",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 30),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(15.0),
            ),
            width: double.infinity,
            height: 50,
            child: TextButton.icon(
                onPressed: () async {
                  if (widget.app.source == 'internal') {
                    DownloadController()
                        .downloadFile(widget.app.dowlink, widget.app.id);
                  } else {
                    DownloadController().launchUrls(
                        Uri.parse(widget.app.dowlink), widget.app.id);
                  }
                  getcount();
                  setState(() {});
                },
                icon: const Icon(
                  Icons.download,
                  color: Colors.white,
                ),
                label: Text(
                  "${widget.app.source == 'internal' ? 'Download APK' : 'Download'}  (${widget.app.size})",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                )),
          ),
        ),
        const SizedBox(
          height: 15,
          width: double.infinity,
        ),
      ],
    );
  }
}

class ImageViewMobile extends StatelessWidget {
  const ImageViewMobile({super.key, required this.app});
  final AppDetail app;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 30),
      child: Container(
        height: 230,
        //color: Colors.red,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: app.ss.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 5),
              child: InkWell(
                onTap: () {
                  open(context, index, app);
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  elevation: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: ExtendedImage.network(
                      app.ss[index],
                      enableLoadState: true,
                      fit: BoxFit.contain,
                      cache: true,
                      borderRadius: BorderRadius.circular(10.0),
                      loadStateChanged: (ExtendedImageState state) {
                        switch (state.extendedImageLoadState) {
                          case LoadState.failed:
                            state.reLoadImage();
                            break;
                          case LoadState.loading:
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 230,
                                width: 110,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Image.asset(
                                    "assets/loading.gif",
                                    fit: BoxFit.contain,
                                    // scale: 2,
                                    height: 220,
                                    width: 210,
                                  ),
                                ),
                              ),
                            );

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
              ),
            );
          },
        ),
      ),
    );
  }
}
