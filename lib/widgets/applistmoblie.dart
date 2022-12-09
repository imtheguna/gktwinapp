import 'package:flutter/material.dart';
import 'package:twin_apps/models/appdetailmodels.dart';
import 'package:twin_apps/models/appstore.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:extended_image/extended_image.dart';

class ApplistMobile extends StatefulWidget {
  final AppStore store;
  final ValueChanged<AppDetail> onTapped;
  final ValueChanged<AppStore> onTappedApp;
  const ApplistMobile(
      {super.key,
      required this.store,
      required this.onTapped,
      required this.onTappedApp});

  @override
  State<ApplistMobile> createState() => _ApplistMobileState();
}

class _ApplistMobileState extends State<ApplistMobile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(top: 15, bottom: 15, right: 20, left: 20),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 6,
          child: Container(
            padding: const EdgeInsets.only(right: 5, left: 5),
            height: 350,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 227, 248, 255),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: VxSwiper.builder(
                    onPageChanged: (i) => SrcIndex(i, widget.store),
                    autoPlayInterval: Duration(milliseconds: 2000),
                    autoPlayAnimationDuration: Duration(milliseconds: 1500),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    viewportFraction: 0.8,
                    // aspectRatio: 1,
                    itemCount: widget.store.appDetails.length - 10,
                    height: 200,
                    itemBuilder: (context, i) {
                      return Card(
                        child: Container(
                          height: 150,
                          width: 250,
                          child: VxBuilder(
                              mutations: {SrcIndex},
                              builder: (context, _, __) {
                                return InkWell(
                                  onTap: () => widget.onTapped(
                                      widget.store.appDetails[i + 1]!),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        height: 140,
                                        child: ExtendedImage.network(
                                          widget.store.appDetails[i + 1]!.logo,
                                          enableLoadState: true,
                                          fit: BoxFit.contain,
                                          cache: true,
                                          loadStateChanged:
                                              (ExtendedImageState state) {
                                            switch (
                                                state.extendedImageLoadState) {
                                              case LoadState.failed:
                                                state.reLoadImage();
                                                break;
                                              case LoadState.loading:
                                                break;
                                              case LoadState.completed:
                                                if (state
                                                    .wasSynchronouslyLoaded) {
                                                  return state.completedWidget;
                                                }
                                                break;
                                            }
                                          },
                                        ),
                                      ),
                                      widget.store.srcIndex == i
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 6, top: 3, left: 6),
                                              child: Center(
                                                child: Text(
                                                  widget.store
                                                      .appDetails[i + 1]!.name,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 14),
                  child: InkWell(
                    onTap: () => widget.onTappedApp(widget.store),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Browse More ',
                          style: TextStyle(
                              color: Color.fromRGBO(89, 139, 231, 1),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Color.fromRGBO(89, 139, 231, 1),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

// Container(
//         color: Color.fromARGB(255, 227, 248, 255),
//         height: 400,
//         width: double.infinity,
//       ).