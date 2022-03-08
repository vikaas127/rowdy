import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class TokenAPI {



  Future<http.Response> Video_Call_API() async {


   // print(await http.read(Uri.parse('https://example.com/foobar.txt')));
    var uri = Uri.parse("https://brtechgeeks.in/agora/RtcTokenBuilderSample.php");

    final response = await http.get(uri);
    print(response.body);

    int status = response.statusCode;
    return response;
  }

}