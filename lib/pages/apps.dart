import 'package:flutter/material.dart';
import 'package:twin_apps/controller/downloadercontroller.dart';
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
import 'package:twin_apps/widgets/getofffset.dart';
import 'package:twin_apps/widgets/webapplist.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:twin_apps/main.dart';

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
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController msgcontroller = TextEditingController();
  List<String> listofSev = [
    'Web Design',
    'Web Development',
    'App Development',
    'Other'
  ];

  final _formKey = GlobalKey<FormState>();

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
        controller: scrollController,
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
            Center(
              child: GetBoxOffse(
                offset: (offset) {
                  Setoffset(
                    offset.dy,
                    'Apps',
                  );
                },
                child: widget.store.appDetails.isNotEmpty
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
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            if (width < 1000)
              MyPackages(
                width: width,
                isweb: false,
              ),
            GetBoxOffse(
                offset: (offset) {
                  Setoffset(
                    offset.dy,
                    'packages',
                  );
                },
                child: const DevDetailsPage()),
            const SizedBox(
              height: 5,
            ),
            if (width > 1000)
              GetBoxOffse(
                offset: (offset) {
                  Setoffset(
                    offset.dy,
                    'Contact',
                  );
                },
                child: ContactPageWeb(
                  store: widget.store,
                ),
              ),
            if (width < 1000)
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Form(
                          key: _formKey,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width,
                                  child: const Text('Contact Form',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w300)),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                MyInput(
                                  textHeight: 60,
                                  text: "Your Name",
                                  controller: namecontroller,
                                  maxline: 1,
                                  height: 100,
                                ),
                                MyInput(
                                  textHeight: 60,
                                  text: 'Email',
                                  controller: emailcontroller,
                                  maxline: 1,
                                  height: 100,
                                ),
                                MyInput(
                                  textHeight: 60,
                                  text: 'Phone Number',
                                  controller: phonecontroller,
                                  maxline: 1,
                                  height: 100,
                                ),
                                Container(
                                  height: 300,
                                  //width: ((width * 0.43) / 2) - 12,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text("Message"),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 250,
                                        child: TextFormField(
                                          maxLines: 12,
                                          controller: msgcontroller,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: const Color.fromARGB(
                                                31, 178, 178, 178),
                                            hintText: "Message",
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 14.0,
                                                    bottom: 8.0,
                                                    top: 8.0),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(7.7),
                                            ),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(7.7),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Message empty';
                                            } else if (value.length < 10) {
                                              return 'Message short';
                                            }

                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: width,
                                  child: const Text("Services",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                VxBuilder(
                                  mutations: {SelectSev},
                                  builder: (context, _, __) {
                                    return Container(
                                        width: width,
                                        height: 50,
                                        child: ListView.builder(
                                          itemCount: listofSev.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: ((context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: (() => SelectSev(
                                                    index, widget.store)),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: widget.store
                                                                .selectSev ==
                                                            index
                                                        ? Colors.white
                                                        : Color.fromARGB(
                                                            31, 162, 162, 162),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: widget.store
                                                                      .selectSev ==
                                                                  index
                                                              ? Colors.blue
                                                              : Colors
                                                                  .transparent,
                                                          spreadRadius: 1),
                                                    ],
                                                  ),
                                                  height: 30,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      listofSev[index],
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        ));
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Center(
                                    child: InkWell(
                                        onTap: (() {
                                          try {
                                            bool isvalidated = _formKey
                                                .currentState!
                                                .validate();
                                            if (isvalidated) {
                                              SetIsemail(true);
                                              print(listofSev[
                                                  widget.store.selectSev]);
                                              DownloadController().sendMail(
                                                  name: namecontroller.text,
                                                  mnumber: phonecontroller.text,
                                                  email: emailcontroller.text,
                                                  sev: listofSev[
                                                      widget.store.selectSev],
                                                  msg: msgcontroller.text);
                                              Future.delayed(
                                                      Duration(seconds: 3))
                                                  .then((value) {
                                                SetIsemail(false);
                                                context.showToast(
                                                    msg: 'Message Sent');
                                              });
                                            }
                                          } catch (e) {
                                            context.showToast(
                                                msg:
                                                    'Sometimes wrong, Try again');
                                          }
                                        }),
                                        child: VxBuilder(
                                            mutations: {SetIsemail},
                                            builder: (context, _, status) {
                                              return AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 700),
                                                height: 45,
                                                width:
                                                    widget.store.isemailsending
                                                        ? 60
                                                        : 200,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(widget.store
                                                              .isemailsending
                                                          ? 30
                                                          : 6),
                                                  color: const Color.fromARGB(
                                                      255, 255, 203, 125),
                                                ),
                                                child: Center(
                                                    child: widget.store
                                                            .isemailsending
                                                        ? const CircularProgressIndicator()
                                                        : const Text(
                                                            'Send Message',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )),
                                              );
                                            })))
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(
              height: 20,
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