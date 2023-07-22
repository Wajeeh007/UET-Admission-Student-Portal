import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class DateOfBirthForm extends StatefulWidget {

  String? fieldName;
  TextEditingController? fieldController;
  double? receivedWidth;

  DateOfBirthForm({
    super.key,
   this.fieldName,
    this.fieldController,
    this.receivedWidth
});

  @override
  State<DateOfBirthForm> createState() => _DateOfBirthFormState();
}

class _DateOfBirthFormState extends State<DateOfBirthForm> {

  late DateTime minus18Years;
  DateTime? datePicker;
  @override
  void initState() {
    DateTime currentDate = DateTime.now();
    minus18Years = DateTime(currentDate.year - 18);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          widget.fieldName.toString(),
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 14
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        TextFormField(
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.center,
          controller: widget.fieldController,
          validator: (value){
            if(value == null || value == ''){
              return 'Enter Date';
            }
            else{
              return null;
            }
          },
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 3),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1
              )
            ),
            constraints: BoxConstraints(
              maxWidth: widget.receivedWidth ?? MediaQuery.of(context).size.width/3.3
            ),
          ),
          readOnly: true,
          onTap: ()async{
            datePicker = await showDatePicker(
                context: context,
                initialDate: minus18Years,
                firstDate: DateTime(1950),
                lastDate: minus18Years,
            );
            if(datePicker != null){
              String convertedDate = DateFormat('dd-MM-yyyy').format(datePicker!);
              setState(() {
                widget.fieldController!.text = convertedDate;
              });
            }
          },
        )
      ],
    );
  }
}