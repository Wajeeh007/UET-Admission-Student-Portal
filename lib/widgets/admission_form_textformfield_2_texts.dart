import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'admission_form_textformfields.dart';

class AdmissionFormField2Texts extends StatefulWidget {

  AdmissionFormField2Texts({
    super.key,
    this.fieldController,
    this.fieldName,
    this.errorText,
    this.secondText,
    this.width,
    this.inputFilter
  });

  final TextEditingController? fieldController;
  final String? secondText;
  final String? errorText;
  final String? fieldName;
  double? width;
  List<TextInputFormatter>? inputFilter;
  @override
  State<AdmissionFormField2Texts> createState() => _AdmissionFormField2TextsState();
}

class _AdmissionFormField2TextsState extends State<AdmissionFormField2Texts> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AdmissionFormFields(
          fieldController: widget.fieldController,
          fieldName: widget.fieldName,
          fieldValidationFunc: null,
          receivedWidth: widget.width,
          inputFilter: widget.inputFilter
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          widget.secondText.toString(),
          style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16
          ),
        )
      ],
    );
  }
}