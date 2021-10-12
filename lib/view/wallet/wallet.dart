import 'dart:convert';

import 'package:Libmot_Mobile/constants/constants.dart';
import 'package:Libmot_Mobile/models/dat_model.dart';
import 'package:Libmot_Mobile/services/database/user_preference.dart';
import 'package:Libmot_Mobile/services/networking/api_calls.dart';
import 'package:Libmot_Mobile/view/wallet/Fund_wallet_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> with TickerProviderStateMixin {
  TabController controller;
  bool showback = false;
  final key = GlobalKey();
  final _api = ApiCalls();

  UserPreference instance;
  List images = [
    "images/launch.jpeg",
    "images/launch.jpeg",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//        statusBarColor: Colors.white54,
//        statusBarIconBrightness: Brightness.dark));
    UserPreference.getInstance().then((instance) {
      this.instance = instance;
      setState(() {
        walletBalance = instance.getDouble("wallet-balance") ?? 0;
        list = instance.getSavedCards();
      });
    });
    //getWalletBalance();
    controller = TabController(length: 2, vsync: this);
    // getWalletTransactions().then((list) {
    //   setState(() {
    //     history = list;
    //   });
    // });
  }

  double walletBalance = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 1,
        child: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 180.0,
                floating: true,
                pinned: false,
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Theme.of(context).primaryColor,
                actions: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10, vertical: 10),
//                     child: FlatButton(
//                       textColor: Colors.grey[900],
//                       color: Colors.white,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(5))),
//                       onPressed: () {
//                         // Get.to(() => FundWalletPage(instance).then((amount){
//                         //    setState(() {
//                         //      walletBalance = amount;
//                         //    });
//                         //   getWalletBalance();
// //                         Navigator.push(context,
// //                             createRoute(FundWalletPage(instance)))
// //                             .then((amount) {
// // //                            setState(() {
// // //                              walletBalance = amount;
// // //                            });
// //                           getWalletBalance();
// //                         });
//                       },
//                       child: Text(
//                         "Fund wallet",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16),
//                       ),
//                     ),
//                   )
                ],
                snap: true,
                flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                  print(
                      "testing    ${constraints.biggest.height.toString()}");
                  return FlexibleSpaceBar(
                      centerTitle: false,
                      title: Container(
                        width: MediaQuery.of(context).size.width,
                        transform: Matrix4.translationValues(-40, 0, 0),
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 100),
                          opacity: (constraints.biggest.height > 110) ? 1 : 0,
                          child: Container(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.account_balance_wallet,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "wallet balance",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.white,
                                    height: 4,
                                    endIndent: 0,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                    child: Text(
                                        walletBalance < 1
                                            ? "${getNairaSign()}$walletBalance"
                                            : formatMoney(
                                            walletBalance),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      background: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Colors.black54, BlendMode.srcATop),
                          child: Container(
                            height: 110,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: CarouselSlider(
                                      options: CarouselOptions(
                                        height: 310,
                                        viewportFraction: 1.0,
                                        autoPlay: true,
                                      ),
                                      items: images
                                          .map(
                                            (item) => Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  30)),
                                          child: Image.asset(
                                            item,
                                            fit: BoxFit.fill,
                                            width: 550,
                                          ),
                                        ),
                                      )
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
//                    background:
                  );
                }),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: controller,
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(
                        icon: Icon(Icons.history),
                        text: "Transactions history",
                      ),
                      Tab(icon: Icon(Icons.credit_card), text: "My Cards"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            controller: controller,
            children: <Widget>[getHistoryList(), getCardList()],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Get.to(FundWalletPage());
        },
        backgroundColor: Theme.of(context).primaryColor,
        label: Text('Fund Wallet',style: TextStyle(color: Colors.white),),
        icon: Icon(Icons.wallet_giftcard,color: Colors.white,),
      ),

    );

  }

  List<TransactionObject> history;
  bool loading = false;

  Widget getHistoryList() {
    return StatefulBuilder(builder: (context, state) {
      if (history == null && !loading) {
        return Center(
          child: Icon(
            Icons.error,
            color: Colors.red[300],
            size: 80,
          ),
        );
      } else if (loading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (history.length > 0 && !loading) {
        return ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemBuilder: (context, index) {
            String date = DateFormat.yMEd()
                .format(DateTime.parse(
                history[history.length - (index + 1)].TransactionDate))
                .toString();
            return Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "${getNairaSign()}${history[history.length - (index + 1)].TransactionAmount.floor().toString()}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700]),
                          ),
                          Row(
                            children: <Widget>[
                              (!history[history.length - (index + 1)]
                                  .IsCompleted ??
                                  false)
                                  ? Text(
                                "",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 10),
                              )
                                  : SizedBox(),
                              Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(5),
                                color: getColorCode(
                                    history[history.length - (index + 1)]
                                        .TransType),
                                child: Text(
                                  history[history.length - (index + 1)]
                                      .TransType,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "${history[history.length - (index + 1)].TransactionDescription}",
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[700]),
                          ),
                          Text(
                            date,
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
          },
          itemCount: history.length,
        );
      } else {
        return Center(
          child: Text("No history found!"),
        );
      }
    });
  }

  List<CreditCard> list = List();
  Widget getCardList() {
//    list = instance.getSavedCards();
//    double h = MediaQuery.of(context).size.width;
    double w = MediaQuery.of(context).size.width - 20;
    double h = MediaQuery.of(context).size.width * 0.50;
    return (list.isEmpty)
        ? Center(
      child: Text("No cards saved."),
    )
        : ListView.builder(
      itemBuilder: (context, index) {
        Color c = getRandomColor(index);
        return Container(
            child: CreditCardWidget(
              cardHolderName: "",
              cardNumber: list[index].cardNumber,
//                    maskCardNumber(list[index].cardNumber.replaceAll(" ", "")),
              cvvCode: list[index].cvv,
              expiryDate: "${list[index].expMonth}/${list[index].expYear}",
              showBackView: showback,
              //background: getCardBackground(w, h, c),
              height: h,
              width: w,
              cardBgColor: Colors.transparent,
              // onTap: () {
              //   setState(() {
              //     showback = !showback;
              //   });
              // },
              // onLongTap: () {
              //   showDialog(
              //       context: context,
              //       builder: (context) {
              //         return AlertDialog(
              //           title: Text("Warning"),
              //           content: Text(
              //               "Are you sure you want to delete this card?"),
              //           actions: <Widget>[
              //             FlatButton(
              //               child: Text("Ok"),
              //               onPressed: () {
              //                 Navigator.of(context, rootNavigator: true)
              //                     .pop(true);
              //               },
              //             ),
              //             FlatButton(
              //               child: Text("Cancel"),
              //               onPressed: () {
              //                 // Get.to(() => WalletPage()
              //                 // Navigator.pushAndRemoveUntil(
              //                 //     context,
              //                 //     createRoute(WalletPage()),
              //                 //     ModalRoute.withName("dashboard"));
              //               },
              //             )
              //           ],
              //         );
              //       });
              // },
            ));
      },
      itemCount: list.length,
    );
//    return
  }

  // void getWalletBalance() async {
  //   print("get wallet");
  //   Response response = await _api.getWalletInfo();
  //   print(response.bodyString);
  //   if (response.statusCode == 200) {
  //     Map result = json.decode(response.bodyString);
  //     setState(() {
  //       walletBalance = result['Balance'];
  //       UserPreference.getInstance().then((instance) {
  //         instance.setDouble("wallet-balance", walletBalance);
  //       });
  //     });
  //   }
  // }

  Color getColorCode(String type) {
    if (type == "Credit") {
      return Colors.green[800];
    } else if (type == "Debit") {
      return Colors.red[800];
    }
    return Colors.grey[700];
  }

//   Future<List<TransactionObject>> getWalletTransactions() async {
//     setState(() {
//       loading = true;
//     });
//     Response response = await _api.getWalletTransaction();
//
//     setState(() {
//       loading = false;
//     });
//
//     if (response.isSuccessful) {
//       Iterable result = json.decode(response.bodyString);
//       List<TransactionObject> transactions =
//       result.map((obj) => TransactionObject.fromJson(obj)).toList();
//       return transactions;
//     }
//     return null;
//   }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Material(
      color: Colors.white,
      child: _tabBar,
      elevation: 5,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
