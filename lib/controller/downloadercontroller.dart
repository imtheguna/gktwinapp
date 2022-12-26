import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'package:http/http.dart' as http;
import 'package:twin_apps/controller/firebaseMag.dart';
import 'dart:html' as html;
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class DownloadController {
  void downloadFile(String url, int id) {
    html.AnchorElement anchorElement = html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
    FireStoreDataBase().updateDownCount(id: id);
  }

  shareweb() {
    Share.share('Check out my website https://gktwinapp.com/');
  }

  Future<void> launchUrls(Uri url, int id) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch url';
    }
    if (id != -1) {
      FireStoreDataBase().updateDownCount(id: id);
    }
  }

  Future sendMail(
      {required String name,
      required String mnumber,
      required String email,
      required String sev,
      required String msg}) async {
    final Uri url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    final rep = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': 'service_immvhve',
        'template_id': 'template_nbmrxve',
        'user_id': 'Z9YHCE7BwiJBwZ32b',
        'template_params': {
          'reply_to': email.trim(),
          'from_name': name,
          'to_name': 'Team',
          'number': mnumber,
          'message': 'I\'m $name, $msg',
          'your_subject': 'Gk Apps : $sev'
        }
      }),
    );
  }
}
