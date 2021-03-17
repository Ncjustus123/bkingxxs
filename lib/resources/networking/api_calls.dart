import 'dart:convert';
import 'dart:io';

import 'package:Libmot_Mobile/models/get_buses_model.dart';
import 'package:Libmot_Mobile/resources/database/user_preference.dart';
import 'package:http/http.dart' as http;

import 'package:Libmot_Mobile/resources/networking/end_points.dart';

import 'end_points.dart';
import 'end_points.dart';
import 'getBase.dart';
import 'getBase.dart';

class ApiCalls {
  Future<Map<String, String>> init() async {
    final preference = await UserPreference.getInstance();
    final token = await preference.getToken();
    var header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };
    return header;
  }

  Future<http.Response> login(String email, String password) async {
    final header = await init();
    final url = baseInstance.base.baseUrl + EndPoints.getToken;
    var body = json.encode({"username": email, "password": password});
    final response = await http.post(url, body: body, headers: header);
    return response;
  }

  Future<http.Response> profile(String token) async {
    final header = await init();
    final url = baseInstance.base.baseUrl + EndPoints.getProfile;
    final response = await http.get(url, headers: header);
    return response;
  }

  Future<http.Response> getAllRoutes() async {
    final header = await init();
    final url = baseInstance.base.baseUrl + EndPoints.getTerminals;
    final response = await http.get(url, headers: header);
    return response;
  }

  Future<http.Response> postHireBus(Map<String, dynamic> body) async {
    final header = await init();
    final url = baseInstance.base.baseUrl + EndPoints.postHireBus;
    final response =
        await http.post(url, body: json.encode(body), headers: header);
    return response;
  }

  Future<http.Response> getDestinationTerminals(int id) async {
    final header = await init();
    final url = baseInstance.base.baseUrl +
        EndPoints.getDestinationTerminal +
        id.toString();
    final response = await http.get(url, headers: header);
    return response;
  }

  Future<http.Response> searchBuses(Map<String, dynamic> body) async {
    final header = await init();
    final url = baseInstance.base.baseUrl + EndPoints.searchBuses;
    //final body = json.encode(body);
    final response =
        await http.post(url, body: json.encode(body), headers: header);
    return response;
  }

  Future<http.Response> getBookingStatus(String bookingRef) async {
    final header = await init();
    final url =
        baseInstance.base.baseUrl + EndPoints.getBookingDetails + bookingRef;
    final response = await http.get(url, headers: header);
    return response;
  }

  Future<http.Response> agentRequest(Map<String, dynamic> body) async {
    final header = await init();
    final url = baseInstance.base.baseUrl + EndPoints.postAgentRequest;
    final response =
        await http.post(url, body: json.encode(body), headers: header);
    return response;
  }
}
