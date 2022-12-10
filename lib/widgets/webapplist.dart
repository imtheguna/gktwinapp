import 'package:flutter/material.dart';
import 'package:twin_apps/models/appdetailmodels.dart';
import 'package:twin_apps/models/appstore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:velocity_x/velocity_x.dart';

class MyCard extends StatefulWidget {
  final AppStore store;
  final ValueChanged<AppDetail> onTapped;
  const MyCard({super.key, required this.store, required this.onTapped});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  String getTag(List tag) {
    String tag1 = '';
    for (int i = 0; i < tag.length; i++) {
      tag1 = tag1 + "|" + tag[i];
    }
    return tag1.replaceFirst('|', '');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int _selectindex = -1;
    return Center(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: widget.store.appDetails.length,
        itemBuilder: (ctx, i) {
          String tag = getTag(widget.store.appDetails[i + 1]!.tag);
          // print(tag);
          return Padding(
            padding: width > 800
                ? EdgeInsets.only(
                    top: i % 2 == 0 ? 12 : 0, bottom: i % 2 == 0 ? 0 : 12)
                : EdgeInsets.all(0),
            child: Card(
              elevation: 10,
              shadowColor: Color.fromARGB(255, 97, 100, 101),
              child: InkWell(
                onTap: (() => widget.onTapped(widget.store.appDetails[i + 1]!)),
                child: Container(
                  //  duration: Duration(milliseconds: 500),
                  height: 1 == i ? 400 : 290,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                              child: ExtendedImage.network(
                            widget.store.appDetails[i + 1]!.logo,
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
                          )),
                          Padding(
                            padding: const EdgeInsets.only(right: 5, top: 3),
                            child: Text(
                              widget.store.appDetails[i + 1]!.name,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          Text(
                            widget.store.appDetails[i + 1]!.size,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black45,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: width > 800 ? 4 : 1,
          childAspectRatio: 10.0,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10,
          mainAxisExtent: 264,
        ),
      ),
    );
  }
}

class ApplistWeb extends StatelessWidget {
  final AppStore store;
  final ValueChanged<AppDetail> onTapped;
  const ApplistWeb({super.key, required this.store, required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        //clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            bottom: 0,
            left: -300,
            child: VxCapsule(
              width: 870.0,
              height: 400.0,
              backgroundColor: Color.fromARGB(255, 251, 223, 181),
              // decoration: const BoxDecoration(
              //   color: Color.fromARGB(255, 251, 223, 181),
              //   shape: BoxShape.circle,
              // ),
            ),
          ),
          Positioned(
            bottom: 500,
            right: -300,
            child: Container(
              width: 600.0,
              height: 500.0,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 235, 209, 250),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: -300,
            child: Container(
              width: 600.0,
              height: 500.0,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 227, 248, 255),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(
              top: 2,
              right: 25,
              left: 25,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 1500,
                  //color: Color.fromRGBO(238, 250, 252, 1),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 10),
                    child: MyCard(
                      onTapped: onTapped,
                      store: store,
                    ),
                  )),
            ),
          )),
        ],
      ),
    );
  }
}
