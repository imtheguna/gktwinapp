import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twin_apps/controller/downloadercontroller.dart';
import 'package:twin_apps/pages/mypack.dart';

class DevDetailsPage extends StatelessWidget {
  const DevDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width > 1000 ? WebDev() : MobileDev();
  }
}

class MobileDev extends StatelessWidget {
  const MobileDev({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        // height: 1000,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Container(
                    width: 300,
                    height: 300,
                    child: Image.asset('assets/dev.png'),
                  ),
                ),
              ),
              const Center(
                child: Text("Developers",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w300)),
              ),
              const SizedBox(
                height: 15,
              ),
              StreamBuilder<Object>(
                  stream: FirebaseFirestore.instance
                      .collection("devdetail")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> streamSnapshot) {
                    if (!streamSnapshot.hasData || streamSnapshot.hasError) {
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
                              const Text('Loading...'),
                            ],
                          ),
                        ),
                      );
                    }

                    return Center(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: streamSnapshot.data.docs.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: ((context, index) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom: 20,
                                  left: (width * 0.25),
                                ),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(90.0),
                                            ),
                                            elevation: 10,
                                            shadowColor: index % 2 == 0
                                                ? const Color.fromARGB(
                                                    255, 114, 1, 124)
                                                : const Color.fromARGB(
                                                    255, 124, 65, 1),
                                            child: Container(
                                              width: 180.0,
                                              height: 180.0,
                                              decoration: BoxDecoration(
                                                color: const Color(0xff7c94b6),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      streamSnapshot.data
                                                          .docs[index]['img']),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(90.0)),
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
                                          Text(
                                              streamSnapshot.data.docs[index]
                                                  ['name'],
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300)),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                              streamSnapshot.data.docs[index]
                                                  ['role'],
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
                                                              .data.docs[index]
                                                          ['cont']['link']),
                                                      -1);
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
                                                      Uri.parse(streamSnapshot
                                                              .data.docs[index]
                                                          ['cont']['git']),
                                                      -1);
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
                                                      Uri.parse(streamSnapshot
                                                              .data.docs[index]
                                                          ['cont']['twt']),
                                                      -1);
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
                                                      Uri.parse(streamSnapshot
                                                              .data.docs[index]
                                                          ['cont']['mid']),
                                                      -1);
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
                              ),
                            );
                          })),
                    );
                  }),
            ]),
      ),
    );
  }
}

class WebDev extends StatelessWidget {
  const WebDev({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 580,
      width: double.infinity,
      //color: Colors.red,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Container(
              width: (width / 2) - 50,
              height: 500,
              child: Image.asset('assets/dev.png'),
            ),
          ),
        ),
        SizedBox(width: width * 0.01),
        MyPackages(
          width: (width / 2) - 50,
          isweb: true,
        ),
      ]),
    );
  }
}

/*Expanded(
          flex: 2,
          child: StreamBuilder<Object>(
              stream: FirebaseFirestore.instance
                  .collection("devdetail")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<dynamic> streamSnapshot) {
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
                                          ? const Color.fromARGB(
                                              255, 114, 1, 124)
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
                                    Text(
                                        streamSnapshot.data.docs[index]['name'],
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300)),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                        streamSnapshot.data.docs[index]['role'],
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
                                                        .data.docs[index]
                                                    ['cont']['link']));
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
                                                Uri.parse(streamSnapshot
                                                        .data.docs[index]
                                                    ['cont']['git']));
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
                                                Uri.parse(streamSnapshot
                                                        .data.docs[index]
                                                    ['cont']['twt']));
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
                                                Uri.parse(streamSnapshot
                                                        .data.docs[index]
                                                    ['cont']['mid']));
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
        )*/