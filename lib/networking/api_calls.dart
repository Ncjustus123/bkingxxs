import 'test_data.dart';

import 'live_data.dart';

class ApiCalls {
  //final base = TestData().testLive();
  TestLiveDataModel base = LiveData().testLive();
}

abstract class TestLiveData {
  TestLiveDataModel testLive();
}

class TestLiveDataModel {
  String baseUrl;
  String flutterwavePublicKey;
  String flutterwaveEncryptionKey;
  String paystackPublicKey;

  TestLiveDataModel(
      {this.baseUrl,
      this.flutterwaveEncryptionKey,
      this.flutterwavePublicKey,
      this.paystackPublicKey});

  Map toJson() {
    Map json = Map();
  }

  // TestLiveDataModel.fromJson(Map<String, dynamic> parsedJson)
  //     : baseUrl = parsedJson['baseUrl'],
  //       flutterwaveEncryptionKey = parsedJson['flutterwaveEncryptionKey'],
  //       flutterwavePublicKey = parsedJson['flutterwavePublicKey'],
  //       paystackPublicKey = parsedJson['paystackPublicKey'];
}
