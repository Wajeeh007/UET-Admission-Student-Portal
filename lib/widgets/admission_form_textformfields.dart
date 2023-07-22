import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdmissionFormFields extends StatefulWidget {

  final TextEditingController? fieldController;
  final String? fieldName;
  final String? Function(String?)? fieldValidationFunc;
  double? receivedWidth;
  TextInputType? keyboardType;
  String? initialValue;
  List <TextInputFormatter>? inputFilter;
  bool takeWholeWidth;

  AdmissionFormFields({
    this.fieldController,
    this.fieldName,
    this.fieldValidationFunc,
    this.receivedWidth,
    this.keyboardType,
    this.initialValue,
    this.inputFilter,
    this.takeWholeWidth = false,
  });

  @override
  State<AdmissionFormFields> createState() => _AdmissionFormFieldsState();
}

class _AdmissionFormFieldsState extends State<AdmissionFormFields> {

  @override
  void dispose() {
    widget.fieldController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
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
          widget.takeWholeWidth ? Expanded(
            child: TextFormField(
              initialValue: widget.fieldController?.text == '' ? null : widget.fieldController?.text,
              keyboardType: widget.keyboardType ?? TextInputType.text,
              onChanged: (value){
                setState(() {
                  widget.fieldController!.text = value.toString();
                });
              },
              inputFormatters: widget.inputFilter,
              validator: widget.fieldValidationFunc,
              cursorColor: Colors.black,
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14
              ),
              decoration: const InputDecoration(
                errorMaxLines: 2,
                  constraints: BoxConstraints(
                    maxHeight: 38
                  ),
                  errorStyle: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      )
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      )
                  ),
                  contentPadding: EdgeInsets.only(left: 10, bottom: 10)
              ),
            ),
          ) : TextFormField(
            initialValue: widget.fieldController?.text == '' ? null : widget.fieldController?.text,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            onChanged: (value){
              setState(() {
                widget.fieldController!.text = value.toString();
              });
            },
            inputFormatters: widget.inputFilter,
            validator: widget.fieldValidationFunc,
            cursorColor: Colors.black,
            textAlignVertical: TextAlignVertical.center,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14
            ),
            decoration: InputDecoration(
                errorMaxLines: 2,
                constraints: BoxConstraints(
                  maxWidth: widget.receivedWidth == null ? MediaQuery.of(context).size.width/4.2 : widget.receivedWidth!.toDouble(),
                ),
                errorStyle: const TextStyle(
                    fontWeight: FontWeight.bold
                ),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1,
                    )
                ),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    )
                ),
                contentPadding: const EdgeInsets.only(left: 10, bottom: 3)
            ),
          ),
        ],
      ),
    );
  }
}