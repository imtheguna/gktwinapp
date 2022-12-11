import 'package:flutter/material.dart';
import 'package:twin_apps/controller/downloadercontroller.dart';
import 'package:twin_apps/models/appstore.dart';
import 'package:twin_apps/pages/mypack.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:math' as math;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }
}

class ContactPageMobile extends StatelessWidget {
  const ContactPageMobile({super.key, required this.store});
  final AppStore store;

  @override
  Widget build(BuildContext context) {
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
    double width = MediaQuery.of(context).size.width;
    final _formKey = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Form(
              key: _formKey,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            fillColor: const Color.fromARGB(31, 178, 178, 178),
                            hintText: "Message",
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(7.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(7.7),
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
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (() => SelectSev(index, store)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: store.selectSev == index
                                        ? Colors.white
                                        : Color.fromARGB(31, 162, 162, 162),
                                    boxShadow: [
                                      BoxShadow(
                                          color: store.selectSev == index
                                              ? Colors.blue
                                              : Colors.transparent,
                                          spreadRadius: 1),
                                    ],
                                  ),
                                  height: 30,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      listofSev[index],
                                      style:
                                          const TextStyle(color: Colors.black),
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
                    bool isvalidated = _formKey.currentState!.validate();
                    if (isvalidated) {
                      print(listofSev[store.selectSev]);
                    }
                  }),
                  child: Container(
                    height: 45,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color.fromARGB(255, 255, 203, 125),
                    ),
                    child: const Center(
                        child: Text(
                      'Send Message',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

/**************************************************************************************************/

class ContactPageWeb extends StatelessWidget {
  const ContactPageWeb({super.key, required this.store});
  final AppStore store;

  @override
  Widget build(BuildContext context) {
    TextEditingController namecontroller = TextEditingController();
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController phonecontroller = TextEditingController();
    TextEditingController msgcontroller = TextEditingController();

    double width = MediaQuery.of(context).size.width;
    final _formKey = GlobalKey<FormState>();

    List<String> listofSev = [
      'Web Design',
      'Web Development',
      'App Development',
      'Other'
    ];

    return Container(
      width: double.infinity,
      height: 700,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.05,
          ),
          DevWebPage(),
          Padding(
            padding: const EdgeInsets.only(top: 100, right: 30),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 30),
                  child: Container(
                    height: 550,
                    child: Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: width * 0.43,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Contact Form',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300)),
                                SizedBox(
                                  height: 20,
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: width * 0.43,
                                        height: 300,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: (width * 0.43) / 2,
                                              height: 300,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
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
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Container(
                                              height: 300,
                                              width: ((width * 0.43) / 2) - 12,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
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
                                                      decoration:
                                                          InputDecoration(
                                                        filled: true,
                                                        fillColor: const Color
                                                                .fromARGB(
                                                            31, 178, 178, 178),
                                                        hintText: "Message",
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 14.0,
                                                                bottom: 8.0,
                                                                top: 8.0),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      7.7),
                                                        ),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      7.7),
                                                        ),
                                                      ),
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return 'Message empty';
                                                        } else if (value
                                                                .length <
                                                            10) {
                                                          return 'Message short';
                                                        }

                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Text("Services",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300)),
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
                                                onTap: (() =>
                                                    SelectSev(index, store)),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color: store.selectSev ==
                                                            index
                                                        ? Colors.white
                                                        : Color.fromARGB(
                                                            31, 162, 162, 162),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: store.selectSev ==
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
                                    bool isvalidated =
                                        _formKey.currentState!.validate();
                                    if (isvalidated) {
                                      print(listofSev[store.selectSev]);
                                    }
                                  }),
                                  child: Container(
                                    height: 45,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: const Color.fromARGB(
                                          255, 255, 203, 125),
                                    ),
                                    child: const Center(
                                        child: Text(
                                      'Send Message',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                ))
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
                Positioned(
                    bottom: -2,
                    right: -10,
                    child: Container(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/conlogo.png'))
                        .rotate(15)
                    //.rotate90(),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyInput extends StatefulWidget {
  final String text;
  final int maxline;
  final double height;
  final double textHeight;
  final TextEditingController? controller;
  const MyInput(
      {super.key,
      required this.text,
      this.controller,
      required this.maxline,
      required this.height,
      required this.textHeight});

  @override
  State<MyInput> createState() => _MyInputState();
}

class _MyInputState extends State<MyInput> {
  final fn = FocusNode();
  // void initState() {
  //   Future.delayed(const Duration(milliseconds: 200)).then((_) {
  //     FocusScope.of(context).requestFocus(fn);
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(widget.text),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: widget.textHeight,
            child: TextField(
              // autofocus: false,
              maxLines: widget.maxline,
              focusNode: fn,
              controller: widget.controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(31, 178, 178, 178),
                hintText: widget.text,
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(7.7),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(7.7),
                ),
              ),
              // validator: (value) {
              //   if (widget.text == "Email") {
              //     final bool emailValid = RegExp(
              //             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              //         .hasMatch(value!);
              //     if (!emailValid) return "Invalid Email";
              //     return null;
              //   }
              //   if (widget.text == 'Phone Number') {
              //     final bool emailValid =
              //         RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value!);
              //     if (!emailValid) return "Invalid Number";
              //     return null;
              //   }
              //   if (value!.isEmpty) {
              //     return '${widget.text} empty';
              //   } else if (value.length < 3) {
              //     return '${widget.text} short';
              //   }

              //   return null;
              // },
            ),
          ),
        ],
      ),
    );
  }
}

class DevWebPage extends StatelessWidget {
  const DevWebPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        flex: 3,
        child: StreamBuilder<Object>(
            stream:
                FirebaseFirestore.instance.collection("devdetail").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<dynamic> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                    itemCount: streamSnapshot.data.docs.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            right: 50, top: index % 2 == 0 ? 0 : 70),
                        child: Container(
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                    elevation: 10,
                                    shadowColor: index % 2 == 0
                                        ? const Color.fromARGB(255, 114, 1, 124)
                                        : Color.fromARGB(255, 124, 65, 1),
                                    child: Container(
                                      width: 200.0,
                                      height: 200.0,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff7c94b6),
                                        image: DecorationImage(
                                          image: NetworkImage(streamSnapshot
                                              .data.docs[index]['img']),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(100.0)),
                                        border: Border.all(
                                          color: index % 2 == 0
                                              ? const Color.fromARGB(
                                                  255, 250, 194, 255)
                                              : const Color.fromARGB(
                                                  255, 255, 219, 194),
                                          width: 4.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(streamSnapshot.data.docs[index]['name'],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300)),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(streamSnapshot.data.docs[index]['role'],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w300)),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          DownloadController().launchUrls(
                                              Uri.parse(streamSnapshot
                                                      .data.docs[index]['cont']
                                                  ['link']));
                                        },
                                        child: const FaIcon(
                                          FontAwesomeIcons.linkedinIn,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          DownloadController().launchUrls(
                                              Uri.parse(streamSnapshot.data
                                                  .docs[index]['cont']['git']));
                                        },
                                        child: const FaIcon(
                                          FontAwesomeIcons.github,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          DownloadController().launchUrls(
                                              Uri.parse(streamSnapshot.data
                                                  .docs[index]['cont']['twt']));
                                        },
                                        child: const FaIcon(
                                          FontAwesomeIcons.twitter,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          DownloadController().launchUrls(
                                              Uri.parse(streamSnapshot.data
                                                  .docs[index]['cont']['mid']));
                                        },
                                        child: const FaIcon(
                                          FontAwesomeIcons.medium,
                                          color: Colors.greenAccent,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }));
              }
              return Padding(
                padding: EdgeInsets.all(17.0),
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
                ),
              );
            }),
      ),
    );
  }
}
