import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RateAppinitWidget extends StatefulWidget {
  final Widget Function(RateMyApp) builder;
  const RateAppinitWidget({this.builder});
  @override
  _RateAppinitWidgetState createState() => _RateAppinitWidgetState();
}

class _RateAppinitWidgetState extends State<RateAppinitWidget> {
  RateMyApp rateMyApp;
  static const playstoreId = "com.example.libmot_mobile_flutter ";
   static const applestoreId = "";
  @override
  Widget build(BuildContext context) => RateMyAppBuilder(
        rateMyApp: RateMyApp(
          googlePlayIdentifier: playstoreId,
          appStoreIdentifier: applestoreId,
          minDays: 0,
          minLaunches: 2,
        ),
        onInitialized: (context, rateMyApp) {
          setState(() => this.rateMyApp = rateMyApp);

          if (rateMyApp.shouldOpenDialog) {
            rateMyApp.showRateDialog(context);
          }
        },
        builder: (context)=>rateMyApp == null
        ? Center(child:CircularProgressIndicator())
        :widget.builder(rateMyApp),
      );
}
