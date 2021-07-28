import 'package:Libmot_Mobile/Reusables/appBar.dart';
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
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        width: _width,
        height: _height,
        child: Column(
          children: [
            myAppBar(context, 'Help & Support'),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                  child: Container(
                     padding: const EdgeInsets.fromLTRB(10,25,20,20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(45))),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,10,15,0),
                    child: Text(initialText,textAlign: TextAlign.center,),
                  ),
                  Divider(),
                  liveChat(),
                  callCustomerCare(),
                  emailCustomerCare(),
                  termsCondition(),
                  faqs(),
                  complaints(context),
                ]),
              )),
            ),
          ],
        ),
      ),
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
