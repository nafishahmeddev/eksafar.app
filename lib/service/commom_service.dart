import 'dart:convert';

import 'package:eksafar/redux/actions.dart';
import 'package:eksafar/redux/store.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonService{
  static const String _host = "stage.eksafar.club";
  static const int _port = 443;
  static const String _path = "/api";
  static const String _scheme = "https";
  static generateUri(String path, {Map<String, dynamic>?queryParams}) {
    return Uri(host: _host, port: _port, path: _path+path, scheme: _scheme, queryParameters: queryParams);
  }

  static generateHeader(){
    return {
      "Accept":"application/json",
      "Content-Type": "application/json"
    };
  }

  static generateSecureHeader() async{
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString("access_token")!;
    var headers = generateHeader();
    headers["Authorization"] = "Bearer $accessToken";
    return headers;
  }

  static generateResourceUrl(String path){
    return "$_scheme://$_host:$_port$path";
  }

  static dynamic analyzeResponse(Response response){
    try{
      var body = json.decode(response.body);
      if(response.statusCode == 200) {
        return body;
      } else if(response.statusCode == 403){
        appStore.dispatch(LogoutAction());
        throw Exception(body["message"]);
      } else {
        throw Exception(body["message"]);
      }
    } catch(err){
      throw Exception(err);
    }
  }

}