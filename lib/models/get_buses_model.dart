class GetBusesModel {
  String departureDate;
  int departureTerminalId;
  int destinationTerminalId;
  int numberOfAdults;
  int numberOfChildren;
  String returnDate;
  int tripType;

  GetBusesModel(
      {this.departureDate,
      this.departureTerminalId,
      this.destinationTerminalId,
      this.numberOfAdults,
      this.numberOfChildren,
      this.returnDate,
      this.tripType});



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['departureDate'] = this.departureDate;
    data['departureTerminalId'] = this.departureTerminalId;
    data['destinationTerminalId'] = this.destinationTerminalId;
    data['numberOfAdults'] = this.numberOfAdults;
    data['numberOfChildren'] = this.numberOfChildren;
    data['returnDate'] = this.returnDate;
    data['tripType'] = this.tripType;
    return data;
  }
}
