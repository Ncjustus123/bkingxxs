import 'dart:convert';
import 'dart:io';
import 'package:Libmot_Mobile/services/database/user_preference.dart';
import 'package:http/http.dart' as http;

import 'package:Libmot_Mobile/services/networking/end_points.dart';

import 'end_points.dart';
import 'getBase.dart';

class ApiCalls {
  Future<Map<String, String>> init() async {
    final preference = await UserPreference.getInstance();
    var token = await preference.getToken();
    // var token = tokenResponse.object.token;
    // final currentTime = DateTime.now();
    // final expiresIN = DateTime.parse(tokenResponse.object.expires);

    // if (expiresIN.isBefore(currentTime)) {
    //   //call the refresh token endpoint.
    // tokenResponse =  await UserRepository().loginForAndroidIos();
    // token = tokenResponse.object.token;

    // final refresh
    final header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };
    return header;
  }

  Future<http.Response> login(String email, String password) async {
    final header = {HttpHeaders.contentTypeHeader: 'application/json'};
    final url = Uri.parse(baseInstance.base.baseUrl + EndPoints.getToken);
    var body = json.encode({"username": email, "password": password});
    final response = await http.post(url, body: body, headers: header);
    return response;
  }

  Future<http.Response> profile(String token) async {
    //final header = await init();
    final header = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };
    final url = Uri.parse(baseInstance.base.baseUrl + EndPoints.getProfile);
    final response = await http.get(url, headers: header);
    return response;
  }

  Future<http.Response> getAllRoutes() async {
    final header = await init();
    final url = Uri.parse(baseInstance.base.baseUrl + EndPoints.getTerminals);
    final response = await http.get(url, headers: header);
    return response;
  }

  Future<http.Response> postHireBus(Map<String, dynamic> body) async {
    final header = await init();
    final url = Uri.parse(baseInstance.base.baseUrl + EndPoints.postHireBus);
    print(url);
    final response =
        await http.post(url, body: json.encode(body), headers: header);
    return response;
  }

  Future<http.Response> getDestinationTerminals(int id) async {
    final header = await init();
    final url = Uri.parse(baseInstance.base.baseUrl +
        EndPoints.getDestinationTerminal +
        id.toString());
    print(url);
    final response = await http.get(url, headers: header);
    return response;
  }

  Future<http.Response> searchBuses(Map<String, dynamic> body) async {
    final header = await init();
    final url = Uri.parse(baseInstance.base.baseUrl + EndPoints.searchBuses);
    //final body = json.encode(body);
    final response =
        await http.post(url, body: json.encode(body), headers: header);
    return response;
  }

  Future<http.Response> postBooking(Map<String, dynamic> body) async {
    final header = await init();
    final url = Uri.parse(baseInstance.base.baseUrl + EndPoints.postBooking);
    final response =
        await http.post(url, body: json.encode(body), headers: header);
    return response;
  }

  Future<http.Response> checkBookingStatus(String bookingRef) async {
    final header = await init();
    final url = Uri.parse(
        baseInstance.base.baseUrl + EndPoints.getBookingDetails + bookingRef);
    print(url);
    final response = await http.get(url, headers: header);
    return response;
  }

  Future<http.Response> getTripHistory(String phonenumber) async {
    final header = await init();
    final url = Uri.parse(
        baseInstance.base.baseUrl + EndPoints.getTripHistory + phonenumber);
    final response = await http.get(url, headers: header);
    print(url);
    return response;
  }

  Future<http.Response> agentRequest(Map<String, dynamic> body) async {
    final header = await init();
    final url =
        Uri.parse(baseInstance.base.baseUrl + EndPoints.postAgentRequest);
    final response =
        await http.post(url, body: json.encode(body), headers: header);
    return response;
  }

  Future<http.Response> signUpCustomer(Map<String, dynamic> body) async {
    final header = await init();
    final url = Uri.parse(baseInstance.base.baseUrl + EndPoints.signUpCustomer);
    print(body);
    final response =
        await http.post(url, body: json.encode(body), headers: header);
    return response;
  }

  Future<http.Response> payStackPayment(Map<String, dynamic> body) async {
    final header = await init();
    final url =
        Uri.parse(baseInstance.base.baseUrl + EndPoints.payStackPayment);
    final response =
        await http.post(url, body: json.encode(body), headers: header);
    return response;
  }

  Future<http.Response> agentRegister(Map<String, dynamic> body) async {
    final header = await init();
    final url = Uri.parse(baseInstance.base.baseUrl + EndPoints.agentRegister);
    //final body = json.encode(body);
    final response =
        await http.post(url, body: json.encode(body), headers: header);
    return response;
  }

  Future<http.Response> activateAccount(String username, String otp) async {
    final queryParameters = {
      'userNameOrEmail': username,
      'activationCode': otp,
    };
    print(queryParameters);
    String queryString = Uri(queryParameters: queryParameters).query;

    final header = await init();
    //final url = Uri.https(baseInstance.base.baseUrl, EndPoints.activateAccount,queryParameters);
    final url = Uri.parse(baseInstance.base.baseUrl +
        EndPoints.activateAccount +
        '?' +
        queryString);
    final response = await http.post(url, headers: header);

    return response;
  }

  Future<http.Response> resendOtp(String username) async {
    final queryParameters = {
      'userNameOrEmail': username,
    };
    print(queryParameters);
    String queryString = Uri(queryParameters: queryParameters).query;

    final header = await init();
    final url = Uri.parse(
        baseInstance.base.baseUrl + EndPoints.resendOtp + '?' + queryString);
    final response = await http.post(url, headers: header);

    return response;
  }
}
