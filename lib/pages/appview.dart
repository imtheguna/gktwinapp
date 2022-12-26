import 'package:flutter/material.dart';

import 'package:twin_apps/models/appdetailmodels.dart';
import 'package:twin_apps/models/appstore.dart';
import 'package:twin_apps/models/devdetails.dart';
import 'package:twin_apps/pages/appviewmobile.dart';
import 'package:twin_apps/pages/appviewweb.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AppView extends StatefulWidget {
  final ValueChanged<AppDetail> onTapped;
  final AppDetail app;

  final AppStore store;
  const AppView(
      {super.key,
      required this.app,
      required this.store,
      required this.onTapped});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  DevDetails devDetails =
      DevDetails(address: '', email: '', policylink: '', website: '');

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("devDetails")
              .get()
              .asStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/loading.gif",
                          //  scale: 1,
                          height: 300,
                          width: 300,
                        ),
                        Text('Loading...'),
                      ],
                    ),
                  ));
            }
            Map<String, dynamic> dev = snapshot.data!.docs[0].data();
            return width > 1000
                ? AppViewWeb(
                    dev: dev,
                    onTapped: widget.onTapped,
                    app: widget.app,
                    store: widget.store,
                  )
                : AppViewMobile(
                    dev: dev,
                    app: widget.app,
                    store: widget.store,
                  );
          }),
    );
  }
}
