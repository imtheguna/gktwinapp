import 'package:flutter/material.dart';
import 'package:twin_apps/widgets/video_widget.dart';
import 'package:flutter/material.dart';
import 'package:twin_apps/models/constants.dart';

class Mobileintro extends StatefulWidget {
  const Mobileintro({super.key});

  @override
  State<Mobileintro> createState() => _MobileintroState();
}

class _MobileintroState extends State<Mobileintro> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      child: Column(
        children: [
          Container(
            height: 400,
            padding: const EdgeInsets.only(top: 15, bottom: 20),
            //color: Colors.red,

            //width: width * 0.45,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: width * 0.3,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 45),
                      child: Image.asset(
                        'assets/3dlogo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SelectableText(
                          "Do you know\nwho I am?",
                          style: TextStyle(
                              fontSize: 37,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: width * 0.43,
                          child: Wrap(
                            children: const [
                              SelectableText(
                                "We provide informative, fun, and useful android apps for daily use. It's completely safe, so have faith in us.",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
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
              width: width * 0.90,
              height: height * 0.35 < 300 ? 300 : height * 0.35,
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
    );
  }
}
