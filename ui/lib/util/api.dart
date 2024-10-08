import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

final Logger logger = Logger('API');

class API {
  static const String baseUrl = 'http://127.0.0.1:8000/wealingo/v1/';
  

  static Future<dynamic> get(String endpoint) async {
    // logger.info('in get');
    logger.info(baseUrl+endpoint);
    final response = await http.get(Uri.parse(baseUrl + endpoint));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from server');
    }
  }

  static Future<dynamic> post(String endpoint, String data) async {
    final response = await http.post(
                Uri.parse(baseUrl + endpoint), 
                body: data,
                headers: {
                  'Content-Type': 'application/json',  
                });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from server');
    }
  }

}


