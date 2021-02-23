import 'api_calls.dart';

class LiveData implements TestLiveData {
  TestLiveDataModel testLive() {
    return TestLiveDataModel(
      baseUrl: "http://client.libmot.com/",
      flutterwaveEncryptionKey: "FLWPUBK-add64679c55bac888696922e372cecb5-X",
      flutterwavePublicKey: "26c03b274b07e6a19b179978",
      paystackPublicKey: "pk_live_d1932e5d05139fd5911b4d212d285d5027ffbbe7",
    );
  }
}
