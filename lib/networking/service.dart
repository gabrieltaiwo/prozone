import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> setProvidersData(Map<String, dynamic> body) async {
  String requestURL = "https://pro-zone.herokuapp.com/providers";
  // const token =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjExNTYzNjEzLCJleHAiOjE2MTQxNTU2MTN9.e5Df8V75KU44Hz4IG1ilKby0ptkJzX7hFcbX5XZ-EEI";
  // body.putIfAbsent("active_status", () => "Pending");
  http.Response response =
      await http.post(requestURL, body: json.encode(body), headers: {
    HttpHeaders.authorizationHeader:
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjExNTYzNTg3LCJleHAiOjE2MTQxNTU1ODd9.KLKN7sJGyoz8y2tFHCiYbTkxRFqtJUuhSzaxtuDedco'
  });
  print(response.statusCode);
  final Map<String, dynamic> responseData = json.decode(response.body);
  if (response.statusCode >= 200 && response.statusCode <= 300) {
    return {"success": true, "data": responseData};
  }

  return {"success": false, "data": responseData};
}

Future<Map<String, dynamic>> uploadImage(filename, String providerId) async {
  String requestURL = "https://pro-zone.herokuapp.com/upload/";
  http.MultipartRequest request =
      http.MultipartRequest('POST', Uri.parse(requestURL));
  request.headers.putIfAbsent(
      "authorization",
      () =>
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MiwiaWF0IjoxNjExNTYzNTg3LCJleHAiOjE2MTQxNTU1ODd9.KLKN7sJGyoz8y2tFHCiYbTkxRFqtJUuhSzaxtuDedco');
  request.files.add(await http.MultipartFile.fromPath('files', filename));
  request.fields['ref'] = 'provider';
  request.fields['refId'] = providerId;
  request.fields['field'] = 'images';

  http.StreamedResponse response = await request.send();
  print(response.statusCode);

  // final Map<String, dynamic> responseData = json.decode(response.reasonPhrase);
  // if (response.statusCode >= 200 && response.statusCode <= 300) {
  return {"success": true, "data": response.reasonPhrase.toString()};
  // }

  // return {"success": false, "data": responseData};
}
