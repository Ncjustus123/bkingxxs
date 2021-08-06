import 'live_data.dart';
import 'test_data.dart';

class GetBase {
  //final base = new TestData(); //Test
   final base = new LiveData(); // Live

  static const kGoogleApiKey = "AIzaSyD6mAOR2Bp-obgXHVCb_iyhTbQliRfhFZM";
  static const String appPackageAndroid = "com.libramotors.libmot";
  static const String appIDIOS = "";
}

final baseInstance = GetBase();

abstract class TestLiveData {
  String baseUrl;
  String flutterwavePublicKey;
  String flutterwaveEncryptionKey;
  String paystackPublicKey;
}
