import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

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
                    'assets/logo.png',
                    height: 70,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                const SizedBox(
                  width: 30,
                ),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SelectableText(
                      'Apps',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const SelectableText(
                      'About',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const SelectableText(
                      'Contact',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 30.0),
            child: Icon(
              Icons.share,
              color: Colors.black87,
            ),
          )
        ],
      ),
    );
  }
}

class AppBarWidgetPhone extends StatelessWidget {
  const AppBarWidgetPhone({super.key});

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
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Image.asset(
                    'assets/logo.png',
                    height: 50,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                const SizedBox(
                  width: 30,
                ),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SelectableText(
                      'Apps',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 30.0),
            child: Icon(
              Icons.menu,
              color: Colors.black87,
            ),
          )
        ],
      ),
    );
  }
}
