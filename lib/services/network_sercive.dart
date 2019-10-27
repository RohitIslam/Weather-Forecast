import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkService {
  final String url;

  const NetworkService(this.url);

  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return print(response.statusCode);
    }
  }
}
