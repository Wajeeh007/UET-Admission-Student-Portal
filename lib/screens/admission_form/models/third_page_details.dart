class ThirdPageDetails{
int? year, rollNo, obtainedMarks, totalMarks, percentage;
String? boardName, paperType;

ThirdPageDetails({
  this.year,
  this.rollNo,
  this.boardName,
  this.obtainedMarks,
  this.totalMarks,
  this.percentage,
  this.paperType
});

  Map<String, dynamic> toJson() => {
    'year': year,
    'rollNo': rollNo,
    'boardName': boardName,
    'obtainedMarks': obtainedMarks,
    'totalMarks': totalMarks,
    'percentage': percentage,
    'paperType': paperType
  };

  factory ThirdPageDetails.fromJson(Map<String, dynamic>json) => ThirdPageDetails(
    year: json['year'],
    rollNo: json['rollNo'],
    boardName: json['boardName'],
    obtainedMarks: json['obtainedMarks'],
    totalMarks: json['totalMarks'],
    percentage: json['percentage'],
    paperType: json['paperType']
  );
}