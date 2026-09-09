import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


class GeminiApi {
  Future <String>sendRequest(String message) async{
    String link = "https://generativelanguage.googleapis.com/v1beta/interactions";
    var uri = Uri.parse(link);

    //----------------
    Map<String,String>? header = {
      "x-goog-api-key": dotenv.get('my_api') ,
    };

    Map<String,String>? body = {
       "model": "gemini-3.8-flash",
       "input": message,
    };

    //----------------

    var request = await http.post(uri,headers: header,body: jsonEncode(body));
    print(request.statusCode);

    var response = request.body;
    var responseBody= jsonDecode(response);
   
    return responseBody['steps'][1]['content'][0]['text'].toString();
  }
}