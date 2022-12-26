import 'package:flutter/material.dart';
import 'package:twin_apps/controller/downloadercontroller.dart';
import 'package:twin_apps/models/appstore.dart';
import 'package:twin_apps/main.dart';

class AppBarWidget extends StatelessWidget {
  // final ScrollController scrollController;
  final AppStore store;
  const AppBarWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Image.asset(
                    'assets/logo3.jpeg',
                    height: 40,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    InkWell(
                      onTap: () {
                        scrollController.animateTo(store.offset['Apps']!,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.fastOutSlowIn);
                      },
                      child: const Text(
                        'Apps',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    InkWell(
                      onTap: () {
                        scrollController.animateTo(store.offset['packages']!,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.fastOutSlowIn);
                      },
                      child: const Text(
                        'Packages',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    InkWell(
                      onTap: () {
                        scrollController.animateTo(store.offset['Contact']!,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.fastOutSlowIn);
                      },
                      child: const Text(
                        'Contact',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              DownloadController().shareweb();
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 30.0),
              child: Icon(
                Icons.share,
                color: Colors.black87,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AppBarWidgetPhone extends StatelessWidget {
  final AppStore store;
  const AppBarWidgetPhone({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Image.asset(
                    'assets/logo3.jpeg',
                    height: 35,
                    width: 35,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    InkWell(
                      onTap: () {
                        scrollController.animateTo(store.offset['Apps']!,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.fastOutSlowIn);
                      },
                      child: const Text(
                        'Apps',
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              DownloadController().shareweb();
            },
            child: const Padding(
              padding:
                  EdgeInsets.only(right: 30.0, left: 30, top: 10, bottom: 10),
              child: Icon(
                Icons.share,
                color: Colors.black87,
              ),
            ),
          )
        ],
      ),
    );
  }
}
