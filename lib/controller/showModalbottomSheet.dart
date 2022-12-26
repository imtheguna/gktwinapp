import 'package:flutter/material.dart';

class ShowModalBottomSheet {
  void modalBottomSheetMenu(
      {required BuildContext context,
      required double height,
      required double width,
      required bool isweb,
      required String t1,
      required String t2,
      required String t3}) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        builder: (builder) {
          return PrivacyView(
            height: height,
            isweb: isweb,
            p: t1,
            info: t2,
            cont: t3,
          );
        });
  }
}

class PrivacyView extends StatefulWidget {
  final double height;
  final bool isweb;
  final String p;
  final String info;
  final String cont;
  //final double width;
  const PrivacyView({
    super.key,
    required this.height,
    required this.isweb,
    required this.p,
    required this.info,
    required this.cont,
  });

  @override
  State<PrivacyView> createState() => _PrivacyViewState();
}

class _PrivacyViewState extends State<PrivacyView> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          child: SingleChildScrollView(
            child: Container(
              height: widget.height,
              color: Colors.transparent,
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: Row(
                    children: [
                      Container(
                        width: width * 0.9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: double.infinity,
                              height: 20,
                            ),
                            const TextWidget(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              padding: EdgeInsets.only(left: 20),
                              size: 22,
                              test: 'Privacy Policy',
                            ),
                            const SizedBox(
                              width: double.infinity,
                              height: 10,
                            ),
                            TextWidget(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              padding: const EdgeInsets.only(
                                left: 20,
                                // right: 20,
                              ),
                              size: 15,
                              test: widget.p,
                            ),
                            const SizedBox(
                              width: double.infinity,
                              height: 10,
                            ),
                            const TextWidget(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              padding: EdgeInsets.only(
                                left: 20,
                              ),
                              size: 22,
                              test: 'Information we collect',
                            ),
                            const SizedBox(
                              width: double.infinity,
                              height: 10,
                            ),
                            TextWidget(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              padding: const EdgeInsets.only(
                                left: 20,
                                // right: 20,
                              ),
                              size: 15,
                              test: widget.info,
                            ),
                            const SizedBox(
                              width: double.infinity,
                              height: 10,
                            ),
                            const TextWidget(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              padding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              size: 22,
                              test: "Contact us",
                            ),
                            const SizedBox(
                              width: double.infinity,
                              height: 10,
                            ),
                            TextWidget(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              padding: const EdgeInsets.only(
                                left: 20,
                                // right: 20,
                              ),
                              size: 15,
                              test: widget.cont,
                            ),
                            if (!widget.isweb)
                              const SizedBox(
                                height: 20,
                              )
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
        if (widget.isweb && (width > 800))
          Positioned(
              right: 30,
              bottom: 0,
              child: SizedBox(
                height: 200,
                width: 220,
                child: Image.asset('assets/py.png'),
              )),
        Positioned(
          right: 20,
          top: 10,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black54,
              )),
        )
      ],
    );
  }
}

class TextWidget extends StatelessWidget {
  final String test;
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final EdgeInsetsGeometry padding;
  const TextWidget(
      {super.key,
      required this.test,
      required this.size,
      required this.fontWeight,
      required this.color,
      required this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Text(
        test,
        style: TextStyle(
          //overflow: TextOverflow.ellipsis,
          fontSize: size,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}

// Privacy Policy
// Protecting your privacy is important to us. We hope the following statement will help you understand how our app deals with the personal identifiable information ('PII') you may occasionally provide to us via Internet (the Google Play Platform).

// Information we collect:
// Ads - Our app may use some providers to show ads. These Ads providers can uses cookies only to identifies your device (as described above), then show ads that are relevant to our app's kind. We don't share any user's data with Facebook or other parties.
// Contact us:
// It should be noted that whether or not to send us your feedback or bug report is a completely voluntary initiative upon your own decision. please feel free to email us at gktwinapp@gmail.com, we will endeavor to provide clear answers to your questions in a timely manner.