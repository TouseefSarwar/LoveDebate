
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lovedebate/Utils/Constants/WebService.dart';
import 'dart:io';
import 'AppExceptions.dart';
class ApiBaseHelper {
 final String _baseUrl = WebService.baseURL;
  //String _baseUrl ;
  Future<dynamic> fetchService({String method,String url, dynamic body, bool isFormData}) async {
    var _header = {'Content-Type' : (isFormData) ? 'application/x-www-form-urlencoded' : 'application/json'};
    if (method == HttpMethod.post){
      if(isFormData != true){
        body = json.encode(body);
      }
      var responseJson;
      try {
        final response = await http.post(_baseUrl + url, headers: _header, body: body);
        responseJson = _returnResponse(response);
      } on SocketException {
        throw FetchDataException('No Internet connection');
      }
      return responseJson ;
    }else if (method == HttpMethod.get){
      var responseJson;
      try {
        final response = await http.get(_baseUrl + url, headers: _header);
        responseJson = _returnResponse(response);
      } on SocketException {
        throw FetchDataException('No Internet connection');
      }
      return responseJson;
    }

  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      return response;
      break;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
      return response;
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}