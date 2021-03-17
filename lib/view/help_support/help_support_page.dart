import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportPage extends StatelessWidget {
  final initialText =
      "Thank you for choosing Libmot. Please use any of the channels below to reach us and know more about our services";
  final libmotPhone = "tel:09031565022";
  final termsConditionUrl = "https://libmot.com/terms.aspx";
  final faqUrl = "https://libmot.com/FAQ.aspx";
  final liveChatUrl = "https://libmot.com";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Text(initialText),
          Divider(),
          liveChat(),
          callCustomerCare(),
          emailCustomerCare(),
          termsCondition(),
          faqs(),
          complaints(context),
        ],
      )),
    );
  }

  Card liveChat() {
    return Card(
      child: ListTile(
        leading: Icon(Icons.chat_bubble),
        title: Text("Live chat"),
        onTap: () {
          _launchInWebViewOrVC(liveChatUrl);
        },
      ),
    );
  }

  Card callCustomerCare() {
    return Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text("Call customer care"),
        onTap: () async {
          await _makePhoneCall(libmotPhone);
        },
      ),
    );
  }

  Card emailCustomerCare() {
    return Card(
      child: ListTile(
        leading: Icon(Icons.email_sharp),
        title: Text("Email customer care"),
        onTap: () {
          launch(_emailLaunchUri.toString());
        },
      ),
    );
  }

  Card termsCondition() {
    return Card(
      child: ListTile(
        leading: Icon(Icons.menu_book),
        title: Text("Terms & Conditions"),
        onTap: () {
          _launchInWebViewOrVC(termsConditionUrl);
        },
      ),
    );
  }

  Card faqs() {
    return Card(
      child: ListTile(
        leading: Icon(Icons.question_answer),
        title: Text("FAQs"),
        onTap: () {
          _launchInWebViewOrVC(faqUrl);
        },
      ),
    );
  }

  Card complaints(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.warning_sharp),
        title: Text("Complaints"),
        onTap: () {
          Navigator.of(context).pushNamed("/complaintsPage");
        },
      ),
    );
  }

  final Uri _emailLaunchUri =
      Uri(scheme: 'mailto', path: 'support@libmot.com', queryParameters: {
    'subject': '',
  });

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      //TODO: show a snackbar
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        //headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
