import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokapp/network/network_exception.dart';

class ApiProvider {

  final String baseUrl = "https://pokapi.biondi.dev/";

  Future<Map<String,String>> _getAuthHeader() async {
    final String token = await FirebaseAuth.instance.currentUser.getIdToken();
    return {
      HttpHeaders.authorizationHeader: "Bearer " + token,
    };
  }

  Future<Map<String,String>> _getPostHeader() async {
    Map<String, String> authHeader = await _getAuthHeader();
    authHeader.addAll({'Content-type': 'application/json'});
    return authHeader;
  }

  Future<dynamic> get(String url) async {
    return _decode(
        await http.get(
          baseUrl + url,
          headers: await _getAuthHeader(),
        )
    );
  }

  Future<dynamic> post(String url, Map<String, dynamic> body) async {
    return _decode(
      await http.post(
        baseUrl + url,
        headers: await _getPostHeader(),
        body: jsonEncode(body),
      )
    );
  }

  dynamic _decode(http.Response response) {
    switch(response.statusCode) {
      case 200:
        return json.decode(response.body.toString());
      case 400:
        throw new BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw new UnauthorisedException(response.body.toString());
      default:
        throw new FetchException(response.body.toString());
    }
  }

}