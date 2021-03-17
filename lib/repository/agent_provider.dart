import 'dart:convert';

import 'package:Libmot_Mobile/models/agent_Registration_model.dart';
import 'package:Libmot_Mobile/resources/networking/api_calls.dart';
import 'package:flutter/cupertino.dart';

class AgentProvider with ChangeNotifier {
  final _api = ApiCalls();
  Future<void> agentRequest(AgentRegistration agentRegistration) async {
    final response = await _api.agentRequest(agentRegistration.toJson());
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
    }
  }
}
