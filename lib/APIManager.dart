import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';


class APIManager {

  Future<dynamic> getData(Map data, String apiUrl) async {
    var url = 'https://liquipedia.net/starcraft2/' + apiUrl;
    var fullUrl = Uri.parse(url);

    var res;
    try {
      var response = await http.get(fullUrl);
      res = _response(response);
    } on SocketException {
      throw ('No Internet connection');
    }
    return res;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;

    }
  }
}