class FirstPageDetails {
  int? eteaID;
  int? meritListNo;
  String? studentName, fatherName, departmentName, campusName, religion, nationality, fatherOccupation, mobileNo;
  String? cnic, maritalStatus, dateOfBirth;

  FirstPageDetails({
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

  factory FirstPageDetails.fromJson(Map<String, dynamic> json) => FirstPageDetails(
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
    dateOfBirth: json['dateOfBirth']
  );
}