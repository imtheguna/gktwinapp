// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:twin_apps/models/appdetailmodels.dart';
import 'package:twin_apps/models/appstore.dart';
import 'package:twin_apps/models/devdetails.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math';

class FireStoreDataBase {
  getSize(Map<int, AppDetail> applist, AppStore store) async {
    final storageRef = FirebaseStorage.instance.ref();
    for (int i = 1; i < applist.length + 1; i++) {
      if (applist[i]!.source == 'internal') {
        final pathReference = storageRef.child(applist[i]!.dowlink);
        final metadata = await pathReference.getMetadata();

        SetSize(getFileSizeString(bytes: metadata.size!), store, i);
      } else {
        SetSize('18MB', store, i);
      }
    }
    return true;
  }

  static String getFileSizeString({required int bytes, int decimals = 0}) {
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  Future getAssteslinks(
      {required String collection, required String field}) async {
    var result = '';
    FirebaseFirestore.instance
        .collection('Assteslinks')
        .snapshots()
        .forEach((element) {
      element.docs.forEach((element) {
        result = element.get(field);
      });
    });
    return result;
  }

  Future getAppsData({required AppStore store}) async {
    Map<int, AppDetail> appDetailsq = {};
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("AppDetails");

    try {
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          store.appDetails[result.get('id')] = AppDetail.toMap(result);
          appDetailsq[result.get('id')] = AppDetail.toMap(result);
        }
      });
      // print(studentsList);
      return appDetailsq;
    } catch (e) {
      print("Error - $e");
      return null;
    }
  }

  Future getAppsApp({required AppStore store}) async {
    Map<int, AppDetail> appDetailsq = {};

    try {
      FirebaseFirestore.instance
          .collection("AppDetails")
          .doc('2')
          .get()
          .then((value) {});

      return appDetailsq;
    } catch (e) {
      print("Error - $e");
      return null;
    }
  }

  Future getDevDetails({required AppStore store}) async {
    Map<String, DevDetails> devDetails = {};
    try {
      await FirebaseFirestore.instance
          .collection("devDetails")
          .doc('details')
          .get()
          .then((value) {
        //print(value.data());
        // store.devDetails['dev'] = DevDetails.toMap(value.data());
        // devDetails['dev'] = DevDetails.toMap(value.data());
      });
      // print(appDetailsq);
      return devDetails;
    } catch (e) {
      print("Error - $e");
      return null;
    }
  }
}
