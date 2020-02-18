import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;



class EventDetail extends StatefulWidget {
    final event;
  //var image_url = 'https://image.tmdb.org/t/p/w500/';
  EventDetail(this.event);
  @override
  EventDetailState createState() {
    return new  EventDetailState(this.event);
  }
}

class  EventDetailState extends State< EventDetail > {
  var bbi;
  final event;
  Color mainColor = Colors.black;
  EventDetailState(this.event);

  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',

    childDirected: false,
    // or MobileAdGender.female, MobileAdGender.unknown
    testDevices: <String>[], // Android emulators are considered test devices
  );
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;


  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId:'ca-app-pub-3266019000562415/4448908875',
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: 'ca-app-pub-3266019000562415/1543543932',
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-3266019000562415~1438508243');
    _bannerAd = createBannerAd()..load() ..show(


    );


  }

  @override
  void dispose() {
    _interstitialAd = createInterstitialAd()..load()..show();
    _interstitialAd?.dispose();
    super.dispose();
  }

  //var image_url = 'https://image.tmdb.org/t/p/w500/';


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey,
        child: Container(
          height: 55,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[




            ],
          ),
        ),
      ),
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title:       new Text(
          event['title'],
          style: new TextStyle(
              color: Colors.white,
              /// fontSize: 12.0,
              fontFamily: 'Arvo'),
        ),
        actions: <Widget>[


        ],
      ),
      backgroundColor: Colors.orange,
      body: new Stack(fit: StackFit.expand, children: [


        new SingleChildScrollView(
          child: new Container(
            margin: const EdgeInsets.all(10.0),
            child: new Column(
              children: <Widget>[

                new Text(event['content'],style: new TextStyle(color: Colors.black, fontFamily: 'Arvo', fontSize: 19.0,)),
                new Padding(padding: const EdgeInsets.all(10.0)),

              ],
            ),
          ),
        )
      ]),
    );
  }
}



