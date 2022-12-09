// ignore_for_file: depend_on_referenced_packages

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:twin_apps/models/constants.dart';
import 'package:twin_apps/models/appdetailmodels.dart';
import 'package:twin_apps/models/appstore.dart';
import 'package:twin_apps/controller/firebaseMag.dart';
import 'package:twin_apps/pages/apps.dart';
import 'package:twin_apps/widgets/appbar_widget.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  final AppStore store;
  final ValueChanged<AppDetail> onTapped;
  final ValueChanged<AppStore> onTappedApp;
  const HomePage(
      {super.key,
      required this.store,
      required this.onTapped,
      required this.onTappedApp});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CustomVideoPlayerWebSettings customVideoPlayerWebSettings =
      // ignore: prefer_const_constructors
      CustomVideoPlayerWebSettings(
          src: widget.store.ProVideoLink, aspectRatio: 1.7);
  getdata() async {
    await FireStoreDataBase().getAppsData(store: widget.store);
  }

  @override
  void initState() {
    super.initState();

    customVideoPlayerWebSettings =
        // ignore: prefer_const_constructors
        CustomVideoPlayerWebSettings(
            src: widget.store.ProVideoLink,
            autoplay: false,
            //enableControls: false,
            aspectRatio: 1.7);
    Constants.customVideoPlayerController = CustomVideoPlayerWebController(
      webVideoPlayerSettings: customVideoPlayerWebSettings,
    );
    if (Constants.customVideoPlayerController.isPlaying.value) {
      Constants.customVideoPlayerController.play;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          width > 600 ? const AppBarWidget() : const AppBarWidgetPhone(),
          VxBuilder(
            builder: (context, storeX, status) {
              if (widget.store.bodyIndex == 0) {
                return Apps(
                  onTappedApp: widget.onTappedApp,
                  onTapped: widget.onTapped,
                  store: widget.store,
                );
              }
              return Apps(
                onTappedApp: widget.onTappedApp,
                onTapped: widget.onTapped,
                store: widget.store,
              );
            },
            mutations: {IndexSet, SetApps, SetDev},
          )
        ],
      ),
    );
  }
}
