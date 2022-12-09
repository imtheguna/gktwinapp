import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppDetail {
  final String lastupdated;
  //final String address;
  final String description;
  final String dowlink;
  //final String email;
  final String name;
  final String source;
  final List tag;
  final List ss;
  final bool ads;
  final String logo;
  final String size;
  final int id;
  final String new_update_details;
  AppDetail(
      {required this.new_update_details,
      //required this.address,
      required this.size,
      required this.logo,
      required this.id,
      required this.ads,
      required this.description,
      required this.dowlink,
      // required this.email,
      required this.name,
      required this.source,
      required this.tag,
      required this.ss,
      required this.lastupdated});

  static AppDetail toMap(QueryDocumentSnapshot<Object?> data) {
    return AppDetail(
        new_update_details: data.get('new_update_details'),
        size: data.get('size'),
        ads: data.get('ads'),
        lastupdated: data.get('Last_Updated'),
        // address: data.get('address'),
        description: data.get('description'),
        dowlink: data.get('dow_link'),
        // email: data.get('email'),
        name: data.get('name'),
        source: data.get('source'),
        ss: data.get('ss'),
        tag: data.get('tag'),
        logo: data.get('logo'),
        id: data.get('id'));
  }

  static AppDetail toMapApp(Map<String, dynamic>? data) {
    return AppDetail(
        ads: data!['ads'],
        new_update_details: data['new_update_details'],
        size: data['size'],
        lastupdated: data['Last_Updated'],
        // address: data['address'],
        description: data['description'],
        dowlink: data['dow_link'],
        // email: data['email'],
        name: data['name'],
        source: data['source'],
        ss: data['ss'],
        tag: data['tag'],
        logo: data['logo'],
        id: data['id']);
  }
}
