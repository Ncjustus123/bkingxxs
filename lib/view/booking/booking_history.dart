import 'dart:convert';

import 'package:Libmot_Mobile/Reusables/appBar.dart';
import 'package:Libmot_Mobile/constants/dialogs/dialog.dart';
import 'package:Libmot_Mobile/controllers/booking_repository.dart';
import 'package:Libmot_Mobile/controllers/booking_status_repository.dart';
import 'package:Libmot_Mobile/controllers/user_repository.dart';
import 'package:Libmot_Mobile/services/networking/api_calls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'booking_history_detail.dart';

class BookingHistory extends StatefulWidget {
  @override
  _BookingHistoryState createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  String phoneNumber = '';
  UserRepository user;
  var historyItem = [];
  bool isFetching = true;



  @override
  void initState() {
    // TODO: implement initState
    boot();
    super.initState();
  }

  boot() async {
    user = Provider.of<UserRepository>(context, listen: false);
    phoneNumber = user.profile.object.phoneNumber;
    getHistory();
  }

  getHistory() async {
    showFetchingData('Fetching booking history');
    print(phoneNumber);

    final response = await ApiCalls().getTripHistory(phoneNumber);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      if (responseData['code'] == '400') {
        EasyLoading.dismiss();

        Dialogs.showErrorSnackBar(
            'Error', 'You do not have any booking history');
        setState(() {
          isFetching = true;
        });
      } else {
        EasyLoading.dismiss();
        print(responseData['object'][0]);
        print(responseData['object'].length);
        setState(() {
          historyItem = responseData['object'] as List;
          isFetching = true;
        });
      }
    }
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: _width,
        height: _height,
        child: Column(
          children: [
            myAppBar(context, 'Booking History'),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(45))),
                child:ListView.builder(
                        padding: const EdgeInsets.only(top: 5.0),
                        itemCount: historyItem.length,
                        itemBuilder: (context, index) {
                          var item = historyItem[index];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => BookingHistoryDetail(),
                                    arguments: {'history': item});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(
                                        color: Colors.teal.withOpacity(0.3),
                                        width: 5),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(12, 8, 12, 8),
                                      color: Colors.blueGrey.withOpacity(0.35),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  // '${item['routeName']}',
                                                  '${SplitTerminal.getInitials(item['routeName'])}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12.0),
                                                  child: Icon(
                                                    Icons.airport_shuttle,
                                                    size: 20,
                                                  ),
                                                ),
                                                Text(
                                                  // '${item['routeName']}',
                                                  
                                                  '${SplitTerminal.getLast(item['routeName'])}',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text('VIew'),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${item['bookingReferenceCode']}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      'Booking Ref.',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${item['bookingReferenceCode']}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      'Booking Status',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${item['departureDate'] ?? 'N/A'}',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      'Departure Date',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '\u20A6${item['amount']}',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Monserrat',
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      'Amount',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
