import 'test_data.dart';


class GetBase {
  final base = new TestData(); //Test
  // final base = new LiveData(); // Live

  static const kGoogleApiKey = "AIzaSyD6mAOR2Bp-obgXHVCb_iyhTbQliRfhFZM";
}

final baseInstance = GetBase();

abstract class TestLiveData {
  String baseUrl;
  String flutterwavePublicKey;
  String flutterwaveEncryptionKey;
  String paystackPublicKey;
}
