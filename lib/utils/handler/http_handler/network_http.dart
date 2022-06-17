import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../config/config/api_endpoints.dart';
import '../../../config/config/pref_string.dart';

class HttpHandler {
  static String endPointUrl = APIEndpoints.endPoint;

  static Future<Map<String, String>> _getHeaders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? commonToken = prefs.getString(PrefString.commonToken);

    if (commonToken != null) {
      debugPrint("user Token -- '$commonToken'");
      return {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'x-auth-token': '$commonToken',
      };
    }if(commonToken != null){
      debugPrint("adminToken -- '$commonToken'");
      return {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'x-auth-token': '$commonToken',
      };
    }
    else {
      debugPrint("Token  null-- '$commonToken $commonToken'");
      return {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
    }
  }

  static Future<Map<String, dynamic>> getHttpMethod({@required String? url, bool isMockUrl = false}) async {
    var header = await _getHeaders();
    debugPrint("Get URL -- '$endPointUrl$url'");
    debugPrint("Get Data -- 'null'");
    http.Response response = await http.get(
      Uri.parse(isMockUrl ? "$url" : "$endPointUrl$url"),
      headers: header,
    );
    debugPrint("Get Response Code -- '${response.statusCode}'");
    debugPrint("Get Response -- '${response.body}'");
    if (response.statusCode == 200) {
      debugPrint("In Get '200'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': null,
      };
      return data;
    } else if (response.statusCode == 400) {
      debugPrint("In Get '400'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "400",
      };
      return data;
    } else if (response.statusCode == 401) {
      debugPrint("In Get '401'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "401",
      };
      return data;
    } else if (response.statusCode == 403) {
      debugPrint("In Get '403'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "403",
      };
      return data;
    } else if (response.statusCode == 404) {
      debugPrint("In Get '404'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "404",
      };
      return data;
    } else if (response.statusCode == 500) {
      debugPrint("In Get '500'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "500",
      };
      return data;
    } else {
      debugPrint("In Get 'else'");
      return {
        'body': null,
        'headers': null,
        'error': "Something Went Wrong",
      };
    }
  }

  static Future<Map<String, dynamic>> postHttpMethod({@required String? url, Map<String, dynamic>? data}) async {
    var header = await _getHeaders();
    debugPrint("Post URL -- '$endPointUrl$url'");
    debugPrint("Post Data -- '$data'");
    http.Response response = await http.post(

      Uri.parse("$endPointUrl$url"),
      headers: header,
      body: data == null ? null : jsonEncode(data),
    );
    debugPrint("Post Response Code -- '${response.statusCode}'");
    debugPrint("Post Response -- '${response.body}'");
    if (response.statusCode == 200) {
      debugPrint("In Post '200'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': null,
      };
      return data;
    } else if (response.statusCode == 400) {
      debugPrint("In Post '400'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "400",
      };
      return data;
    } else if (response.statusCode == 401) {
      debugPrint("In Post '401'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "401",
      };
      return data;
    } else if (response.statusCode == 403) {
      debugPrint("In Post '403'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "403",
      };
      return data;
    } else if (response.statusCode == 404) {
      debugPrint("In Post '404'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "404",
      };
      return data;
    } else if (response.statusCode == 500) {
      debugPrint("In Post '500'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "500",
      };
      return data;
    } else {
      debugPrint("In Post 'else'");
      return {
        'body': response.body,
        'headers': null,
        'error': "Something Went Wrong",
      };
    }
  }

  static Future<Map<String, dynamic>> patchHttpMethod({@required String? url, Map<String, dynamic>? data}) async {
    var header = await _getHeaders();
    debugPrint("Patch URL -- '$endPointUrl$url'");
    debugPrint("Patch Data -- '$data'");
    http.Response response = await http.patch(
      Uri.parse("$endPointUrl$url"),
      headers: header,
      body: data == null ? null : jsonEncode(data),
    );
    debugPrint("Patch Response Code -- '${response.statusCode}'");
    debugPrint("Patch Response -- '${response.body}'");
    if (response.statusCode == 200) {
      debugPrint("In Patch '200'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': null,
      };
      return data;
    } else if (response.statusCode == 400) {
      debugPrint("In Patch '400'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "400",
      };
      return data;
    } else if (response.statusCode == 401) {
      debugPrint("In Patch '401'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "401",
      };
      return data;
    } else if (response.statusCode == 403) {
      debugPrint("In Patch '403'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "403",
      };
      return data;
    } else if (response.statusCode == 404) {
      debugPrint("In Patch '404'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "404",
      };
      return data;
    } else if (response.statusCode == 500) {
      debugPrint("In Patch '500'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "500",
      };
      return data;
    } else {
      debugPrint("In Patch 'else'");
      return {
        'body': null,
        'headers': null,
        'error': "Something Went Wrong",
      };
    }
  }

  static Future<Map<String, dynamic>> putHttpMethod({@required String? url, Map<String, dynamic>? data}) async {
    var header = await _getHeaders();
    debugPrint("Put URL -- '$endPointUrl$url'");
    debugPrint("PUT Data -- '$data'");
    http.Response response = await http.put(
      Uri.parse("$endPointUrl$url"),
      headers: header,
      body: data == null ? null : jsonEncode(data),
    );

    debugPrint("PUT Response code -- '${response.statusCode}'");
    debugPrint("PUT Response -- '${response.body}'");

    if (response.statusCode == 200) {
      debugPrint("In Put '200'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': null,
      };
      return data;
    } else if (response.statusCode == 400) {
      debugPrint("In Put '400'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "400",
      };
      return data;
    } else if (response.statusCode == 401) {
      debugPrint("In Put '401'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "401",
      };
      return data;
    } else if (response.statusCode == 403) {
      debugPrint("In Put '403'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "403",
      };
      return data;
    } else if (response.statusCode == 404) {
      debugPrint("In Put '404'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "404",
      };
      return data;
    } else if (response.statusCode == 500) {
      debugPrint("In Put '500'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "500",
      };
      return data;
    } else {
      debugPrint("In Put 'else'");
      return {
        'body': null,
        'headers': null,
        'error': "Something Went Wrong",
      };
    }
  }

  static Future<Map<String, dynamic>> deleteHttpMethod({@required String? url}) async {
    var header = await _getHeaders();
    debugPrint("Delete URL -- '$endPointUrl$url'");
    debugPrint("Delete Data -- 'null'");
    http.Response response = await http.delete(
      Uri.parse("$endPointUrl$url"),
      headers: header,
    );
    debugPrint("Delete Response Code -- '${response.statusCode}'");
    debugPrint("Delete Response -- '${response.body}'");
    if (response.statusCode == 200) {
      debugPrint("In Delete '200'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': null,
      };
      return data;
    } else if (response.statusCode == 400) {
      debugPrint("In Delete '400'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "400",
      };
      return data;
    } else if (response.statusCode == 401) {
      debugPrint("In Delete '401'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "401",
      };
      return data;
    } else if (response.statusCode == 403) {
      debugPrint("In Delete '403'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "403",
      };
      return data;
    } else if (response.statusCode == 404) {
      debugPrint("In Delete '404'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "404",
      };
      return data;
    } else if (response.statusCode == 500) {
      debugPrint("In Delete '500'");
      Map<String, dynamic> data = {
        'body': response.body,
        'headers': response.headers,
        'error': "500",
      };
      return data;
    } else {
      debugPrint("In Delete 'else'");
      return {
        'body': null,
        'headers': null,
        'error': "Something Went Wrong",
      };
    }
  }
}
