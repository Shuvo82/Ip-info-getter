import 'dart:convert';

import 'package:http/http.dart' as http;

class IpData{


 static Future<String> GetMyIpAddress() async {
   Uri url=Uri.parse("https://api.ipify.org/?format=json");
    http.Response res=await http.get(url);
    if(res.statusCode==200){


      print(jsonDecode(res.body)['ip']);
       return jsonDecode(res.body)['ip'];
    }

    return "No ip found";
  }
  
  
  static GetIpAddressInfo(){

   Uri url=Uri.parse("https://ipinfo.io/182.48.82.31/geo");
  }
}