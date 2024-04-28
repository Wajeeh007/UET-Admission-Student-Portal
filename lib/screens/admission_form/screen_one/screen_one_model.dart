class FirstPageModel {
  String? eteaID, meritListNo, studentName, fatherName, departmentName, campusName, religion, nationality, fatherOccupation, mobileNo;
  String? cnic, maritalStatus, dateOfBirth;

  FirstPageModel({
    this.eteaID,
    this.meritListNo,
    this.studentName,
    this.fatherName,
    this.fatherOccupation,
    this.departmentName,
    this.campusName,
    this.cnic,
    this.mobileNo,
    this.religion,
    this.nationality,
    this.maritalStatus,
    this.dateOfBirth
  });

  Map<String, dynamic> toJson() => {
    'eteaID': eteaID,
    'meritListNo': meritListNo,
    'studentName': studentName,
    'fatherName': fatherName,
    'departmentName': departmentName,
    'campusName': campusName,
    'religion': religion,
    'nationality': nationality,
    'fatherOccupation': fatherOccupation,
    'mobileNo': mobileNo,
    'cnic': cnic,
    'maritalStatus': maritalStatus,
    'dateOfBirth': dateOfBirth
  };

  factory FirstPageModel.fromJson(Map<String, dynamic> json) => FirstPageModel(
    eteaID: json['eteaID'],
    meritListNo: json['meritListNo'],
    studentName: json['studentName'],
    fatherName: json['fatherName'],
    departmentName: json['departmentName'],
    campusName: json['campusName'],
    fatherOccupation: json['fatherOccupation'],
    mobileNo: json['mobileNo'],
    cnic: json['cnic'],
    maritalStatus: json['maritalStatus'],
    dateOfBirth: json['dateOfBirth'],
    religion: json['religion'],
    nationality: json['nationality']
  );
}