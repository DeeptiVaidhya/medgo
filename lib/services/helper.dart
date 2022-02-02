import 'dart:convert';
import 'package:medgo/config/constants.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

// late final uri;
// late String type;
makeHttpRequest(uri, type, Map<String, dynamic> data) async {
  uri = Uri.parse(API_ENDPOINT + uri);
  final LocalStorage storage = new LocalStorage('medgo');
  await storage.ready;
  String token = '';
  if (storage.getItem('token') != null) {
    token = storage.getItem('token');
  }
  //print(token);
  final headers = {
    "Accept": "application/json",
    "Token": token,
    "Content-Type": "application/x-www-form-urlencoded",
    "Authorization": 'Basic ' + AUTH
  };
  var response;
  if (type == 'post') {
    response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(data),
    );
    // print("nts post api---");
    // print(jsonEncode(headers));
    // print("nts reset---");
    // print(response);
    // print(jsonEncode(data));
  } else {
    response = await http.get(uri, headers: headers);
  }
  // print("nts reset---");
  // print(response.body);
  return jsonDecode(response.body);
  // if (response.statusCode == 201) {
  //   return jsonDecode(response.body);
  // } else {
  //   throw Exception('Failed to load');
  // }
}  // }
