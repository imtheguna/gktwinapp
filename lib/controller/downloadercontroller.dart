import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:url_launcher/url_launcher.dart';

class DownloadController {
  void downloadFile(String url) {
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }

  Future<void> launchUrls(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch url';
    }
  }
}
