class SecondPageDetails{
  String? presentAddress, permanentAddress, incomeSource, incomeInLetters, seatType, employerName, employerAddress, boardName, paperType;
  int? year, rollNumber, obtainedMarks, totalMarks, percentage;

  SecondPageDetails({
    this.presentAddress,
    this.permanentAddress,
    this.incomeSource,
    this.incomeInLetters,
    this.seatType,
    this.employerName = '',
    this.employerAddress = '',
    this.boardName,
    this.year,
    this.rollNumber,
    this.paperType,
    this.obtainedMarks,
    this.totalMarks,
    this.percentage
  });

  Map<String, dynamic> toJson() => {
    'presentAddress': presentAddress,
    'permanentAddress': permanentAddress,
    'incomeSource': incomeSource,
    'incomeInLetters': incomeInLetters,
    'seatType': seatType,
    'nameOfEmployer': employerName,
    'addressOfEmployer': employerAddress,
    'year': year,
    'rollNumber': rollNumber,
    'paperType': paperType,
    'obtainedMarks': obtainedMarks,
    'totalMarks': totalMarks,
    'percentage': percentage,
    'boardName': boardName
  };

  factory SecondPageDetails.fromJson(Map<String, dynamic>json) => SecondPageDetails(
    presentAddress: json['presentAddress'],
    permanentAddress: json['permanentAddress'],
    incomeSource: json['incomeSource'],
    incomeInLetters: json['incomeInLetters'],
    seatType: json['seatType'],
    employerName: json['nameOfEmployer'],
    employerAddress: json['addressOfEmployer'],
    year: json['year'],
    rollNumber: json['rollNumber'],
    boardName: json['boardName'],
    paperType: json['paperType'],
    obtainedMarks: json['obtainedMarks'],
    totalMarks: json['totalMarks'],
    percentage: json['percentage'],
  );

}