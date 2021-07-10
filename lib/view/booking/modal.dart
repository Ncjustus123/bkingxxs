import 'package:Libmot_Mobile/Reusables/buttons.dart';
import 'package:Libmot_Mobile/Reusables/text_field.dart';
import 'package:Libmot_Mobile/models/booking_model.dart';
import 'package:Libmot_Mobile/view/booking/passenger_info_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ModalSheet extends StatefulWidget {
  const ModalSheet();

  @override
  _ModalSheetState createState() => _ModalSheetState();
}

class _ModalSheetState extends State<ModalSheet> {
  BeneficiaryType beneficiaryType;
  var beneficiaryController = TextEditingController();
  var myList = [];
  List<Widget> adultBeneficiaryNames = [];
  List<Widget> childrenBeneficiaryNames = [];
  List<Beneficiaries> adultBeneficiary = [];
  List<Beneficiaries> childrenBeneficiary = [];

  @override
  Widget build(BuildContext context) {
    beneficiaryController.clear();
    Beneficiaries beneficiaries = Beneficiaries();
    int seatNumber = myList.last;
    int index = (beneficiaryType.index == 0)
        ? adultBeneficiaryNames.length
        : childrenBeneficiaryNames.length;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.transparent,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
            color: Theme.of(context).scaffoldBackgroundColor),
        height: height * 0.5,
        width: width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 50,
                      height: 4,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Text(
                  'Add Beneficiary\'s Name',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                SizedBox(height: 15),
                Text(
                  'Add the name of a travelling partner',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                InputFormField(
                  label: 'Full Name',
                  textCapitalization: TextCapitalization.words,
                  controller: beneficiaryController,
                ),
                RadioListBuilder(),
                SizedBox(height: 20),
                Buttons.coloredButton(
                    context: context,
                    title: 'Add Beneficiary',
                    onTap: () {
                      Widget listTile = ListTile(
                        leading: Icon(Icons.person),
                        title: Text(beneficiaryController.text),
                        trailing: IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            myList.add(seatNumber);
                            if (beneficiaryType.index == 0) {
                              adultBeneficiary.remove(beneficiaries);
                              adultBeneficiaryNames.removeAt(index);
                            } else {
                              childrenBeneficiary.remove(beneficiaries);
                              childrenBeneficiaryNames.removeAt(index);
                            }

                            setState(() {});
                          },
                        ),
                      );

                      setState(() {
                        beneficiaries.fullName = beneficiaryController.text;

                        beneficiaries.seatNumber = seatNumber;

                        if (beneficiaryType.index == 0) {
                          beneficiaries.passengerType = 0; //adult passenger
                          adultBeneficiaryNames.insert(index, listTile);
                          adultBeneficiary.add(beneficiaries);
                        } else {
                          beneficiaries.passengerType = 1; //child passenger
                          childrenBeneficiaryNames.insert(index, listTile);
                          childrenBeneficiary.add(beneficiaries);
                        }

                        myList.remove(seatNumber);
                      });
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
