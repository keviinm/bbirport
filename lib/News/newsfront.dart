import 'dart:async';
import 'dart:convert';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'newsDetails.dart';
//import 'package:bbi/details.dart';
//import 'config.dart';
bool isLoading = true ;
class NewsList extends StatefulWidget {
  @override
  NewsListState createState() {
    return new NewsListState();
  }
}

class NewsListState extends State<NewsList> {
  var bbi;
  Color mainColor = Colors.black;

  void getData() async {
    var data = await getJson();

    setState(() {
      bbi = data;
      isLoading = false;
    });
    // return null;
  }
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
  @override
  Widget build(BuildContext context) {
    getData();
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return new Scaffold(
      backgroundColor: Colors.lightBlue,
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
        elevation: 0.3,

        backgroundColor: Colors.orange,
//        leading: new Icon(
//          Icons.arrow_back,
//          color: mainColor,
//        ),
        title: new Text(
          'BBI News',
          style: new TextStyle(

              fontFamily: 'Arvo',
              fontWeight: FontWeight.bold),
        ),

      ),
      body: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new BbiTitle(mainColor),

            new Expanded(
              child: new ListView.builder(
                  itemCount: bbi == null ? 0 : bbi.length,
                  itemBuilder: (context, i) {
                    return new
                    GestureDetector(
                        onTap: ()=>   Navigator.push(context,
                            new MaterialPageRoute(builder: (context) {
                              return new NewsDetail(bbi[i]);
                            })),

                        child   :  Container(

                            height: 70,
                            child:
                            Card(
                              elevation: 5,
                              child: new EventCell(bbi, i),
//                      padding: const EdgeInsets.all(0.0),
//                      onTap: () {
//                        Navigator.push(context,
//                            new MaterialPageRoute(builder: (context) {
//                              return new EventDetail(bbi[i]);
//                            }));
//                      },
                              color: Colors.white,
                            )));
                  }),
            )
          ],
        ),
      ),
    );
  }
}

Future<List> getJson() async {
  //var apiKey = getApiKey();
  var url = 'http://hagiologic-balances.000webhostapp.com/floscan/bbinews.php';
  var response = await http.get(url);

  return json.decode(response.body);


}

class BbiTitle extends StatelessWidget {
  final Color mainColor;

  BbiTitle(this.mainColor);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 4.0),
      child: new Text(
        '',
        style: new TextStyle(
            fontSize: 10.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Arvo'),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class EventCell extends StatelessWidget {
  final events;
  final i;
  Color mainColor = const Color(0xff3C3261);

  EventCell(this.events, this.i);

  @override
  Widget build(BuildContext context) {


    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[

            new Expanded(
                child: new Container(
                  margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  child: new Column(
                    children: [
                      new Text(
                        events[i]['Tittle'],
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Arvo',
                            fontWeight: FontWeight.bold,
                            color: mainColor),
                      ),
                      new Padding(padding: const EdgeInsets.all(2.0)),

                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                )),
          ],
        ),

      ],
    );
  }
}
