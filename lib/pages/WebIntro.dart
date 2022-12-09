import 'package:flutter/material.dart';
import 'package:twin_apps/models/constants.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:twin_apps/widgets/video_widget.dart';

class WebIntro extends StatelessWidget {
  const WebIntro({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30, top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 500,
              padding: const EdgeInsets.only(top: 45, bottom: 45),
              //color: Colors.red,

              width: width * 0.45,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 45, bottom: 45),
                      child: Image.asset('assets/3dlogo.png', fit: BoxFit.fill),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Do you know who I am?",
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: (width / 2) * 0.5,
                            child: Wrap(
                              children: const [
                                Text(
                                  "We provide informative, fun, and useful android apps for daily use. It's completely safe, so have faith in us.",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 224, 190),
                      blurRadius: 20.0,
                    ),
                  ],
                ),
                width: width * 0.42,
                height: height * 0.45 < 300 ? 300 : height * 0.45,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 248, 184, 119),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    margin: const EdgeInsets.all(20),
                    child: const VideoWidget(),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
/*Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: const DecorationImage(
                          image: AssetImage(
                              '/Users/guna/FlutterDev/AppsFiles/twin_apps/Asstes/logo.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0)),
                        border: Border.all(
                          color: Colors.black45,
                          width: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          'Gk Twin',
                          style: TextStyle(
                              fontSize: 50,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500),
                        ),
                        const 
                          'Education | Games | Tools',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black45,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )*/
