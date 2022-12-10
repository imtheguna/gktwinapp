import 'package:flutter/material.dart';
import 'package:twin_apps/controller/firebaseMag.dart';
import 'package:twin_apps/models/appdetailmodels.dart';
import 'package:twin_apps/models/appstore.dart';
import 'package:twin_apps/pages/Mobileintro.dart';
import 'package:twin_apps/pages/WebIntro.dart';
import 'package:twin_apps/pages/applist.dart';
import 'package:twin_apps/pages/contact.dart';
import 'package:twin_apps/pages/devdetails.dart';
import 'package:twin_apps/pages/mypack.dart';
import 'package:twin_apps/widgets/applistmoblie.dart';
import 'package:twin_apps/widgets/webapplist.dart';
import 'package:velocity_x/velocity_x.dart';

class Apps extends StatefulWidget {
  final AppStore store;
  final ValueChanged<AppDetail> onTapped;
  final ValueChanged<AppStore> onTappedApp;
  const Apps(
      {super.key,
      required this.store,
      required this.onTapped,
      required this.onTappedApp});

  @override
  State<Apps> createState() => _AppsState();
}

class _AppsState extends State<Apps> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/ban.png',
              width: width,
              // color: Colors.amber,
              fit: width > 600
                  ? (height * 0.69) < 300
                      ? BoxFit.contain
                      : BoxFit.cover
                  : BoxFit.contain,
              height: width > 600
                  ? (height * 0.69) < 300
                      ? 400
                      : height * 0.69
                  : 300,
            ),
            width > 1300 ? const WebIntro() : Mobileintro(),
            const SizedBox(
              height: 30,
            ),
            widget.store.appDetails.isNotEmpty
                ? width > 800
                    ? ApplistWeb(
                        onTapped: widget.onTapped,
                        store: widget.store,
                      )
                    : ApplistMobile(
                        onTappedApp: widget.onTappedApp,
                        onTapped: widget.onTapped,
                        store: widget.store,
                      )
                : Container(),
            const SizedBox(
              height: 15,
            ),
            if (width < 1000)
              MyPackages(
                width: width,
                isweb: false,
              ),
            const DevDetailsPage(),
            const SizedBox(
              height: 20,
            ),
            width > 1000
                ? ContactPageWeb(
                    store: widget.store,
                  )
                : ContactPageMobile(
                    store: widget.store,
                  ),
          ],
        ),
      ),
    );
  }
}

/*ExtendedImage.network(
                          'https://yt3.ggpht.com/H3kPQYenTZJGFSUyqyf7_6PNpsil5L_Qr4oT4_Be6oOCcBnwgT8DiITO-z9BYZFjQIb2amYY=s88-c-k-c0x00ffffff-no-rj',
                          enableLoadState: true,
                          fit: BoxFit.fill,
                          cache: true,
                          border: Border.all(color: Colors.red, width: 1.0),
                          loadStateChanged: (ExtendedImageState state) {
                            switch (state.extendedImageLoadState) {
                              case LoadState.failed:
                                state.reLoadImage();
                                break;

                              case LoadState.loading:
                                // TODO: Handle this case.
                                break;
                              case LoadState.completed:
                                if (state.wasSynchronouslyLoaded) {
                                  return state.completedWidget;
                                }

                                break;
                            }
                          },
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          //cancelToken: cancellationToken,
                        )*/