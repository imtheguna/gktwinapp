import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Container(
            height: 350,
            //width: width,
            //color: Colors.amber,
            child: Container(color: Colors.red, width: width * 0.43),
          ),
        ),
        // Padding(
        //   padding:
        //       const EdgeInsets.only(right: 30, top: 30, left: 30, bottom: 30),
        //   child: Container(
        //     width: width * 0.3,
        //     height: 300,
        //     child: Image.asset("assets/cont.png"),
        //   ),
        // )
      ],
    );
  }
}
