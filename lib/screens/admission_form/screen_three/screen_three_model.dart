class ThirdPageModel{
String? boardName, paperType, year, rollNo, obtainedMarks, totalMarks, percentage;

ThirdPageModel({
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

  factory ThirdPageModel.fromJson(Map<String, dynamic>json) => ThirdPageModel(
    year: json['year'],
    rollNo: json['rollNo'],
    boardName: json['boardName'],
    obtainedMarks: json['obtainedMarks'],
    totalMarks: json['totalMarks'],
    percentage: json['percentage'],
    paperType: json['paperType']
  );
}