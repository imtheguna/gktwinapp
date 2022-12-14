import 'package:flutter/material.dart';
import 'package:twin_apps/controller/downloadercontroller.dart';
import 'package:twin_apps/controller/firebaseMag.dart';
import 'package:twin_apps/controller/showModalbottomSheet.dart';
import 'package:twin_apps/models/appdetailmodels.dart';
import 'package:twin_apps/models/appstore.dart';
import 'package:twin_apps/pages/applist.dart';
import 'package:twin_apps/widgets/appbar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:twin_apps/widgets/applistmoblie.dart';

class AppViewWeb extends StatelessWidget {
  final ValueChanged<AppDetail> onTapped;
  final AppDetail app;
  final Map<String, dynamic> dev;
  final AppStore store;
  const AppViewWeb(
      {super.key,
      required this.app,
      required this.store,
      required this.dev,
      required this.onTapped});

  @override
  Widget build(BuildContext context) {
    String disp = app.description.replaceAll('\\n', '\n');
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<int> list = [13, 14];
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
            AppDetails(
              app: app,
            ),
            ImageView(
              app: app,
            ),
            SizedBox(
              width: width,
              // height: 300,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    //width: width / 2,
                    //color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width / 2,
                            child: const Text(
                              'About this app',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                            width: double.infinity,
                          ),
                          SizedBox(
                            width: width / 2,
                            child: SelectableText(
                              disp,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                            width: width / 2,
                          ),
                          const Text(
                            'What\'s new',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4,
                            width: width / 2,
                          ),
                          SizedBox(
                            width: width / 2,
                            child: SelectableText(
                              app.new_update_details,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                            width: width / 2,
                          ),
                          SizedBox(
                            width: width,
                            height: 30,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: app.tag.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color.fromARGB(
                                              255, 208, 208, 208)),
                                      color: Colors.white,
                                      //  border: BoxBorder.lerp(a, b, t),
                                      borderRadius: BorderRadius.circular(6.0),
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
                                            color: Colors.black38,
                                            fontSize: 13),
                                      )),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15,
                            width: width / 2,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    'Developer contact',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                  width: double.infinity,
                                ),
                                InkWell(
                                  onTap: () => DownloadController().launchUrls(
                                      Uri.parse(dev['website']), -1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Container(
                                    width: 450,
                                    child: ListTile(
                                      leading:
                                          const Icon(Icons.wb_cloudy_outlined),
                                      title: const Text('Website'),
                                      subtitle: Text(dev['website']),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => DownloadController().launchUrls(
                                      Uri.parse("mailto:" + dev['email']), -1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
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
                                    // DownloadController()
                                    //     .launchUrls(Uri.parse(dev['policy_link']));

                                    ShowModalBottomSheet().modalBottomSheetMenu(
                                        context: context,
                                        height: 450,
                                        width: width,
                                        isweb: true,
                                        t2: dev['Information'],
                                        t1: dev['Privacy'],
                                        t3: dev['Contact_de']);
                                  },
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Container(
                                    width: 450,
                                    child: ListTile(
                                      leading: const Icon(
                                          Icons.privacy_tip_outlined),
                                      title: const Text('Privacy Policy'),
                                      subtitle: Text(dev['policy_link']),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 30, top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'More Apps',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                              height: list.contains(app.id)
                                  ? height * 0.95
                                  : height * 0.6,
                              width: width / 3,
                              child: ApplistForMbile(
                                isSubview: true,
                                subviewid: app.id,
                                store: store,
                                onTapped: onTapped,
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}

class ImageView extends StatelessWidget {
  const ImageView({super.key, required this.app});
  final AppDetail app;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 50, right: 50, bottom: 30),
      child: Container(
        height: 450,
        //color: Colors.red,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: app.ss.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                open(context, index, app);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
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
                              height: 450,
                              width: 210,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Image.asset(
                                  "assets/loading.gif",
                                  fit: BoxFit.contain,
                                  // scale: 2,
                                  height: 100,
                                  width: 100,
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
            );
          },
        ),
      ),
    );
  }
}

class AppDetails extends StatefulWidget {
  const AppDetails({super.key, required this.app});
  final AppDetail app;

  @override
  State<AppDetails> createState() => _AppDetailsState();
}

class _AppDetailsState extends State<AppDetails> {
  int count = 0;

  getcount() {
    FireStoreDataBase().getCOunt(id: widget.app.id).then(
      (value) {
        setState(() {
          count = value;
        });
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
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 50, right: 30, top: 45, bottom: 10),
          child: Container(
            height: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 30, bottom: 10, top: 10),
                  child: Center(
                    child: SizedBox(
                      height: 250,
                      width: 250,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.app.name,
                        style: const TextStyle(
                          fontSize: 60,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.app.ads == true ? 'Contains ads' : 'No ads',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "$count Downloads",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        width: 250,
                        height: 50,
                        child: TextButton.icon(
                            onPressed: () {
                              if (widget.app.source == 'internal') {
                                DownloadController().downloadFile(
                                    widget.app.dowlink, widget.app.id);
                                getcount();
                                setState(() {});
                              } else {
                                DownloadController().launchUrls(
                                    Uri.parse(widget.app.dowlink),
                                    widget.app.id);
                                getcount();
                                setState(() {});
                              }
                            },
                            icon: const Icon(
                              Icons.download,
                              color: Colors.white,
                            ),
                            label: Text(
                              "${widget.app.source == 'internal' ? 'Download APK' : 'Download'}  (${widget.app.size})",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

void open(BuildContext context, final int index, AppDetail app) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => GalleryPhotoViewWrapper(
        galleryItems: app.ss,
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
        initialIndex: index,
        scrollDirection: Axis.horizontal,
      ),
    ),
  );
}

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List galleryItems;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.galleryItems.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
            ),
            Positioned(
              bottom: 10,
              right: 100,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Image ${currentIndex + 1}/${widget.galleryItems.length}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    decoration: null,
                  ),
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Container(
                    width: 70,
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: TextButton(
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            int count = 0;
                            Navigator.popUntil(context, (route) {
                              return count++ == 1;
                            });
                          }),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final String item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(item),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: index),
    );
  }
}
