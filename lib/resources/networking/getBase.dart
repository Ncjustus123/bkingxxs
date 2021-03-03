import 'test_data.dart';

import 'live_data.dart';

class GetBase {
  final base = new TestData(); //Test
  // final base = new LiveData(); // Live

}

final baseInstance = GetBase();

abstract class TestLiveData {
  String baseUrl;
  String flutterwavePublicKey;
  String flutterwaveEncryptionKey;
  String paystackPublicKey;
}
