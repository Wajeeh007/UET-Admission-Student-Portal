import 'dart:typed_data';

class FourthPageModel{
  String? fieldName;
  String? file;
  Uint8List? pageImage;
  bool showError;
  bool showLoader;

  FourthPageModel({this.fieldName, this.file, this.showError =false, this.showLoader = false});

  Map toJson() {
    return{
      'fieldName': fieldName,
      'filePath': file,
  };
  }

  factory FourthPageModel.fromJson(Map<String, dynamic>json){
    return FourthPageModel(
      file: json['filePath'],
      fieldName: json['fieldName']
    );
  }
}