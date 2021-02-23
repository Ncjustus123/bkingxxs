import 'api_calls.dart';

class TestData implements TestLiveData {
  TestLiveDataModel testLive() {
    return TestLiveDataModel(
      baseUrl: "https://libmotapidevrs.azurewebsites.net/",
      flutterwaveEncryptionKey:
          "FLWPUBK_TEST-1e00133c9f069a54e243726706a3e65b-X",
      flutterwavePublicKey: "FLWSECK_TESTca2800e58bd3",
      paystackPublicKey: "pk_test_27e7ab059cfebe82ad02259faa68ae7712eef139",
    );
  }
}
