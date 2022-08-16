import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiData{
  Future<Map<String,dynamic>> getArticles(String url) async
  {
    var uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    return jsonDecode(response.body);
  }
}