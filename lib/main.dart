import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ip_info/data/ip_info_datasource.dart';
import 'package:ip_info/widgets/ip_info_type.dart';
import 'package:ip_info/widgets/ip_info_valuee.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String ipadd = "No IP found";
  Map ipinfo = {};
  String op = '';
  final TextEditingController ipinputcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xff0F0817),
              image: DecorationImage(
                image: AssetImage("assets/images/bg_highlight.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 130,
                  width: 130,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: TextField(
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center,
                    controller: ipinputcontroller,
                    decoration: const InputDecoration(
                      label: Center(
                          child: Text(
                        "IP Address",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      )),
                      labelStyle: TextStyle(color: Color(0xff432D83)),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(183.2)),
                      ),
                      fillColor: Color(0xff1E163F),
                      filled: true,
                      //labelText: 'IP Address',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff886AE2)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(183.0),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        String ipAddress = await IpData.GetMyIpAddress();
                        ipinputcontroller.text = ipAddress;
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        child: Row(
                          children: const [
                            Text(
                              'My IP',
                              style: TextStyle(
                                color: Color(0xff481E71),
                                fontSize: 20,
                              ),
                            ),
                            Image(
                              image: AssetImage('assets/images/my_ip.png'),
                              height: 34,
                              width: 34,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff886AE2)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(183.0),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        ipadd = ipinputcontroller.text;
                        Uri url = Uri.parse("https://ipinfo.io/$ipadd/geo");
                        http.Response response = await http.get(url);

                        setState(() {
                          ipinfo = jsonDecode(response.body);
                          //print(ipinfo);
                          op = ipinfo['org'];
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        child: Row(
                          children: const [
                            Text(
                              'Get Info',
                              style: TextStyle(
                                color: Color(0xff481E71),
                                fontSize: 20,
                              ),
                            ),
                            Image(
                              image: AssetImage('assets/images/get_info.png'),
                              height: 34,
                              width: 34,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    const Text(
                      "Information about The IP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      ipadd,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IPInfoType(text: "City"),
                          IPInfoType(text: "Region"),
                          IPInfoType(text: "Country"),
                          IPInfoType(text: "Latitude "),
                          IPInfoType(text: "Operator"),
                          IPInfoType(text: ""),
                          IPInfoType(text: "Postal Code"),
                          IPInfoType(text: "Time Zone"),
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IPInfoValue(text: "${ipinfo["city"]}"),
                          IPInfoValue(text: "${ipinfo["region"]}"),
                          IPInfoValue(text: "${ipinfo["country"]}"),
                          IPInfoValue(text: "${ipinfo["loc"]}"),
                          IPInfoValue(text: "${ipinfo["org"]}"),
                          IPInfoValue(text: "${ipinfo["postal"]}"),
                          IPInfoValue(text: "${ipinfo["timezone"]}"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
