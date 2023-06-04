import 'dart:io';
import 'package:pdfx/pdfx.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AdmissionFormScreen4 extends StatefulWidget {
  static const admissionFormScreen4 = 'admissionformscreen4';

  @override
  State<AdmissionFormScreen4> createState() => _AdmissionFormScreen4State();
}

class _AdmissionFormScreen4State extends State<AdmissionFormScreen4> {

  File? filePath;

  _pickFile()async{
    final pickedFile = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if(pickedFile != null){
      setState(() {
        filePath = File(pickedFile.files.single.path.toString());
      });
      _renderImage();
    }
  }

  dynamic pageImage;
  File? image;
  _renderImage() async {
    final document = await PdfDocument.openFile(image!.path);
    final page = await document.getPage(1);
    final pageRender = await page.render(width: page.width, height: page.height);

    setState(() {
      pageImage = pageRender!.bytes;
    });
    await page.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              'Admission Form',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '4/5',
                style: TextStyle(
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w600,
                    fontSize: 15
                ),
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Upload Documents',
                    style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    '(Original Documents, PDF only)',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'CNIC/Form-B',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 13
                    ),
                  ),
                  DottedBorder(
                    dashPattern: [
                      12,5
                    ],
                    color: Colors.grey.shade600,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    padding: const EdgeInsets.all(6),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Container(
                        width: MediaQuery.of(context).size.width/2.2,
                        height: 40,
                        child: pageImage == null ? GestureDetector(
                          onTap: ()async{
                            await _pickFile();
                          },
                          child: Center(
                            child: Text(
                              'Upload Here',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ) : Image(image: MemoryImage(pageImage), fit: BoxFit.fill,)
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
