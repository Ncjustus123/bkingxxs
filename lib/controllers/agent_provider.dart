import 'dart:convert';

import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:Libmot_Mobile/models/agent_Registration_model.dart';
import 'package:Libmot_Mobile/services/networking/api_calls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AgentProvider with ChangeNotifier {
  final agentModel = AgentRegistration();
  final _api = ApiCalls();
  Future<void> agentRequest() async {
    showFetchingData('loading');
    final response = await _api.agentRequest(agentModel.toJson());
    print(agentModel.toJson());
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print("agent");
      print(responseData);
      EasyLoading.dismiss();
    }
  }
}

