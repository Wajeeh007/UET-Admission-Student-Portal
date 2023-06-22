import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdmissionFormTextFieldBeforeText extends StatefulWidget {

  AdmissionFormTextFieldBeforeText({
    this.fieldController,
    this.fieldText,
    this.receivedWidth,
    this.validation,
    this.inputFilter,
    this.textStyle,
    this.arrangeInColumn = false,
  });

  TextStyle? textStyle;
  String? fieldText;
  TextEditingController? fieldController;
  double? receivedWidth;
  String? Function(String?)? validation;
  List<TextInputFormatter>? inputFilter;
  bool arrangeInColumn;
  @override
  State<AdmissionFormTextFieldBeforeText> createState() => _AdmissionFormTextFieldBeforeTextState();
}

class _AdmissionFormTextFieldBeforeTextState extends State<AdmissionFormTextFieldBeforeText> {
  @override
  Widget build(BuildContext context) {
    return widget.arrangeInColumn ? Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextFormField(
          onChanged: (value){
            setState(() {
              widget.fieldController!.text = value;
            });
          },
          initialValue: widget.fieldController?.text == "" ? null : widget.fieldController?.text,
          inputFormatters: widget.inputFilter,
          textAlignVertical: TextAlignVertical.top,
          validator: widget.validation,
          cursorColor: Colors.black,
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16
          ),
          decoration: InputDecoration(
              errorMaxLines: 2,
              constraints: BoxConstraints(
                maxHeight: 38,
                maxWidth: widget.receivedWidth == null ?
                MediaQuery.of(context).size.width/4.2 : widget.receivedWidth!.toDouble(),
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
              contentPadding: const EdgeInsets.only(left: 10, bottom: 3),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          widget.fieldText.toString(),
          style: widget.textStyle ?? const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16
          ),
        )
        ],
    ) : Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextFormField(
          onChanged: (value){
            setState(() {
              widget.fieldController!.text = value;
            });
          },
          initialValue: widget.fieldController?.text == "" ? null : widget.fieldController?.text,
          inputFormatters: widget.inputFilter,
          textAlignVertical: TextAlignVertical.center,
          validator: widget.validation,
          cursorColor: Colors.black,
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16
          ),
          decoration: InputDecoration(
            errorMaxLines: 2,
              constraints: BoxConstraints(
                maxWidth: widget.receivedWidth == null ?
                MediaQuery.of(context).size.width/4.2 : widget.receivedWidth!.toDouble(),
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
        const SizedBox(
          width: 5,
        ),
        Text(
          widget.fieldText.toString(),
          style: widget.textStyle ?? const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16
          ),
        )
      ],
    );
  }
}