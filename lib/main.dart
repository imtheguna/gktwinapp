// ignore_for_file: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:twin_apps/models/appdetailmodels.dart';
import 'package:twin_apps/models/appstore.dart';
import 'package:twin_apps/controller/firebaseMag.dart';
import 'package:twin_apps/models/devdetails.dart';
import 'package:twin_apps/pages/applist.dart';
import 'package:twin_apps/pages/appview.dart';
import 'package:twin_apps/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:twin_apps/pages/unkownpage.dart';
import './models/firebase_options.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

ScrollController scrollController = ScrollController();
Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(VxState(
    store: AppStore(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppStore store = VxState.store as AppStore;
  getdata() async {
    await FireStoreDataBase().getAppsData(store: store).then((value) {
      store.appDetails = value;
    });
    // await FireStoreDataBase().getDevDetails(store: store).then((value) {
    //   store.devDetails = value;
    // });
  }

  @override
  void initState() {
    SetApps();
    SetApps();
    super.initState();
  }

  final _routeInformationParser = BookRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GK Apps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.slabo27px().fontFamily,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerDelegate: BookRouterDelegate(store, store.appDetails),
      routeInformationParser: _routeInformationParser,
    );
  }
}

class AppRoutePath {
  final int id;
  final bool isUnknown;
  final bool isAppList;

  AppRoutePath.home()
      : id = -1,
        isAppList = false,
        isUnknown = false;

  AppRoutePath.details(this.id)
      : isUnknown = false,
        isAppList = false;

  AppRoutePath.appList()
      : id = -1,
        isAppList = true,
        isUnknown = false;

  AppRoutePath.unknown()
      : id = -1,
        isAppList = false,
        isUnknown = true;

  bool get isHomePage => id == -1;

  bool get isDetailsPage => id != -1;
}

class BookRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  BookRouterDelegate(this.store, this.appDetails)
      : navigatorKey = GlobalKey<NavigatorState>();

  final AppStore store;
  AppDetail? _selectedApp;
  DevDetails? _devDetails;
  final Map<int, AppDetail> appDetails;
  bool show404 = false;
  bool applist = false;
  //AppStore _store = AppStore();
  _handleBookTapped(AppDetail app) {
    _selectedApp = app;
    applist = false;
    notifyListeners();
  }

  _handleApList(AppStore store) {
    store = store;
    applist = true;
    _selectedApp = null;
    notifyListeners();
  }

  AppRoutePath get currentConfiguration {
    if (show404) return AppRoutePath.unknown();
    if (_selectedApp == null && applist == false) return AppRoutePath.home();
    if (applist) return AppRoutePath.appList();

    return AppRoutePath.details(_selectedApp!.id);
  }

  getApps(data) async {
    for (int i = 0; i < data.length;) {
      store.appDetails[data[i]['id']] = AppDetail(
          size: data[i]['size'],
          new_update_details: data[i]['new_update_details'],
          ads: data[i]['ads'],
          lastupdated: data[i]['Last_Updated'],
          //  address: '', // data['address'],
          description: data[i]['description'],
          dowlink: data[i]['dow_link'],
          //  email: '', //data['email'],
          name: data[i]['name'],
          source: data[i]['source'],
          ss: data[i]['ss'],
          tag: data[i]['tag'],
          logo: data[i]['logo'],
          id: data[i]['id']);

      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
            key: ValueKey('HomePage'),
            child: VxBuilder(
              builder: (context, _, status) {
                return StreamBuilder<Object>(
                    stream: FirebaseFirestore.instance
                        .collection("AppDetails")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        var data = streamSnapshot.data.docs;
                        getApps(data);

                        return HomePage(
                          onTappedApp: _handleApList,
                          store: store,
                          onTapped: _handleBookTapped,
                        );
                      }
                      return Scaffold(
                          backgroundColor: Colors.white,
                          body: Padding(
                            padding: const EdgeInsets.all(17.0),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/loading.gif",
                                    //  scale: 1,
                                    height: 300,
                                    width: 300,
                                  ),
                                  Text('Loading...'),
                                ],
                              ),
                            ),
                          ));
                    });
              },
              mutations: {SetApps, SetApps},
            )),
        if (show404)
          const MaterialPage(key: ValueKey('UnknownPage'), child: UnPage()),
        if (applist)
          MaterialPage(
              key: ValueKey('applist'),
              child: AppListview(
                onTapped: _handleBookTapped,
                onTappedApp: _handleApList,
                store: store,
              ))
        else if (_selectedApp != null)
          MaterialPage(
            key: ValueKey('app'),
            child: AppView(
              onTapped: _handleBookTapped,
              // onTapped: _handleBookTapped,
              app: _selectedApp!,
              //devDetails: _devDetails!,
              store: store,
            ),
          )
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        _selectedApp = null;
        show404 = false;
        applist = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    await FireStoreDataBase().getAppsData(store: store).then((value) {
      store.appDetails = value;
    });
    // await FireStoreDataBase().getDevDetails(store: store).then((value) {
    //   store.devDetails = value;
    // });

    if (configuration.isUnknown) {
      _selectedApp = null;
      show404 = true;

      return;
    }
    if (configuration.isAppList) {
      _selectedApp = null;
      show404 = false;
      applist = true;
      return;
    }

    if (configuration.isDetailsPage) {
      if (!store.appDetails.containsKey(configuration.id)) {
        show404 = true;
        return;
      }

      _selectedApp = store.appDetails[configuration.id];
    } else {
      _selectedApp = null;
    }

    show404 = false;
    applist = false;
  }
}

class BookRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    //print(routeInformation.location);
    final uri = Uri.parse(routeInformation.location!);
    // print(uri.pathSegments);
    if (uri.pathSegments.isEmpty) return AppRoutePath.home();

    if (uri.pathSegments.first == 'applist' && uri.pathSegments.length < 2) {
      return AppRoutePath.appList();
    }

    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments.first != 'app') return AppRoutePath.unknown();

      final remaining = uri.pathSegments.last;
      final id = int.tryParse(remaining);
      if (id == null) return AppRoutePath.unknown();

      return AppRoutePath.details(id);
    }

    return AppRoutePath.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(AppRoutePath configuration) {
    if (configuration.isUnknown) {
      return const RouteInformation(location: '/404');
    }
    if (configuration.isAppList) {
      return const RouteInformation(location: '/applist');
    }
    if (configuration.isHomePage) {
      return const RouteInformation(location: '/');
    }

    if (configuration.isDetailsPage) {
      return RouteInformation(location: '/app/${configuration.id}');
    }

    return null;
  }
}

// Future<void> main() async {
//   setPathUrlStrategy();
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(VxState(
//     store: AppStore(),
//     child: MyApp(),
//   ));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     AppStore store = AppStore();
//     return MaterialApp.router(
//       title: 'Twin Apps',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: GoogleFonts.slabo27px().fontFamily,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       routeInformationParser: VxInformationParser(),
//       routerDelegate: VxNavigator(routes: {
//         MyRoutes.home: (_, __) => MaterialPage(
//                 child: HomePage(
//               store: store,
//             )),
//         MyRoutes.app: (uri, __) {
//           final app = store.appDetails[int.parse(uri.queryParameters['id']!)]
//               as AppDetail;
//           return MaterialPage(
//               child: AppView(
//             app: app,
//           ));
//         },
//       }),
//     );
//   }
// }
