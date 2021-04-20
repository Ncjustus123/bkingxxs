import 'package:Libmot_Mobile/models/get_buses_response.dart';
import 'package:flutter/cupertino.dart';

class SeatSelectionRepository extends ChangeNotifier {
  List<int> selectedSeats = [];
  List<SeatObject> allSeats = [];
  

  initialSetUp(Buses bus) {
    //selectedSeats = [];
    //allSeats = [];
    for (int seat in bus.excludedSeats) {
      SeatObject seatObject = new SeatObject();
      seatObject.seatNumber = seat;
      seatObject.status = SeatStatus.blocked;
      allSeats.add(seatObject);
    }

    for (int seat in bus.bookedSeats) {
      SeatObject seatObject = new SeatObject();
      seatObject.seatNumber = seat;
      seatObject.status = SeatStatus.blocked;
      allSeats.add(seatObject);
    }

    for (int seat in bus.availableSeats) {
      SeatObject seatObject = new SeatObject();
      seatObject.seatNumber = seat;
      seatObject.status = SeatStatus.unSelected;
      allSeats.add(seatObject);
    }
  }

  selectSeat(SeatObject seatObject) {
    selectedSeats.add(seatObject.seatNumber);
    seatObject.status = SeatStatus.selected;
    notifyListeners();
  }

  unselectSeat(int i, int seatIndex) {
    allSeats[seatIndex].status = SeatStatus.unSelected;
    selectedSeats.remove(i);
    notifyListeners();
  }
}
 
enum SeatStatus { blocked, selected, unSelected }

class SeatObject {
  int seatNumber;
  SeatStatus status;

  @override
  String toString() {
    return "$seatNumber and $status";
  }
}
