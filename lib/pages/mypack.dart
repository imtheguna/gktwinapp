import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twin_apps/controller/downloadercontroller.dart';

class MyPackages extends StatelessWidget {
  final double width;
  final bool isweb;
  const MyPackages({super.key, required this.width, required this.isweb});

  @override
  Widget build(BuildContext context) {
    //  double width = MediaQuery.of(context).size.width;
    return Container(
      child: StreamBuilder<Object>(
          stream: FirebaseFirestore.instance.collection("packages").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<dynamic> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: SizedBox(
                      width: width,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('Flutter Packages',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w300)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: isweb ? 500 : 800,
                      width: width,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: isweb
                              ? const AlwaysScrollableScrollPhysics()
                              : const NeverScrollableScrollPhysics(),
                          itemCount: streamSnapshot.data.docs.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 2, right: 12, top: 8),
                              child: Card(
                                elevation: 10,
                                shadowColor: Color.fromARGB(255, 136, 135, 252),
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    DownloadController().launchUrls(Uri.parse(
                                        "https://pub.dev/packages/${streamSnapshot.data.docs[index]['name']}"));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white,
                                      // boxShadow: const [
                                      //   BoxShadow(
                                      //       color: Colors.black26,
                                      //       spreadRadius: 1),
                                      // ],
                                    ),
                                    height: isweb ? 120 : 140,
                                    width: width,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15,
                                          left: 10,
                                          right: 10,
                                          bottom: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: width,
                                            child: Text(
                                              streamSnapshot.data.docs[index]
                                                  ['name'],
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: width,
                                            child: Text(
                                                streamSnapshot.data.docs[index]
                                                    ['dec'],
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                )),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              TextButton.icon(
                                                  onPressed: () {
                                                    DownloadController()
                                                        .launchUrls(Uri.parse(
                                                            streamSnapshot.data
                                                                    .docs[index]
                                                                [
                                                                'repository']));
                                                  },
                                                  icon: const FaIcon(
                                                    FontAwesomeIcons.github,
                                                    size: 15,
                                                    color: Colors.blueAccent,
                                                  ),
                                                  label: const Text(
                                                    "Repository",
                                                    style: TextStyle(
                                                      color: Colors.blueAccent,
                                                    ),
                                                  )),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              TextButton.icon(
                                                  onPressed: () {
                                                    DownloadController()
                                                        .launchUrls(Uri.parse(
                                                            streamSnapshot.data
                                                                    .docs[index]
                                                                [
                                                                'APIreference']));
                                                  },
                                                  icon: const FaIcon(
                                                    FontAwesomeIcons.code,
                                                    size: 15,
                                                    color: Color.fromARGB(
                                                        255, 255, 191, 107),
                                                  ),
                                                  label: const Text(
                                                    "API Reference",
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 191, 107),
                                                    ),
                                                  )),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              TextButton.icon(
                                                  onPressed: () {
                                                    DownloadController()
                                                        .launchUrls(Uri.parse(
                                                            streamSnapshot.data
                                                                    .docs[index]
                                                                ['Example']));
                                                  },
                                                  icon: const FaIcon(
                                                    Icons.link,
                                                    color: Colors.teal,
                                                    size: 15,
                                                  ),
                                                  label: const Text(
                                                    "Example",
                                                    style: TextStyle(
                                                      color: Colors.teal,
                                                    ),
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
                    ),
                  )
                ],
              );
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
                    const Text('Loading...'),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
