import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Homepage extends StatelessWidget {
  Homepage({Key? key}) : super(key: key);
  var location;

  getapi() async {
    String url = "https://api.ipify.org/?format=json";
    var res = await get(Uri.parse(url));
    var api = jsonDecode(res.body);
    print(api);
    String url2 = "https://ipinfo.io/161.185.160.93/geo";
    var res2 = await get(Uri.parse(url2));
    // var api2=jsonDecode(res2.body);
    location = jsonDecode(res2.body);
    print(location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Homepage'),),
        body: FutureBuilder(future: getapi(), builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('data');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          } else {
            return Center(
              child: Container(width:double.infinity,height:double.infinity,decoration: BoxDecoration(color: Colors.cyanAccent),
                child: Center(
                  child: Container(decoration: BoxDecoration(color: Colors.yellow),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        // location.toString()
                          'ip=${location['ip']}\ncity=${location['City']}\ncountry=${location['country']}\nloc=${location['loc']}\norg=${location['org']}\npostal=${location['postal']}\ntimezone=${location['timezone']}'
                          ,


                          style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
              ),
            );
          }
        }));
  }
}
