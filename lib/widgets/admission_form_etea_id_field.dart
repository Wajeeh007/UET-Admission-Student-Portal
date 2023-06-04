import 'package:block_input/block_input_controller.dart';
import 'package:block_input/block_input_keyboard_type.dart';
import 'package:block_input/block_input_style.dart';
import 'package:flutter/material.dart';
import 'package:block_input/block_input.dart';

class EteaIDFormField extends StatefulWidget {

  final BlockInputController blockInputController;

  EteaIDFormField(this.blockInputController);

  @override
  State<EteaIDFormField> createState() => _EteaIDFormFieldState();
}

class _EteaIDFormFieldState extends State<EteaIDFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Entrance Test ID No',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700
            ),
          ),
        ),
        BlockInput(
            controller: widget.blockInputController,
            keyboardType: BlockInputKeyboardType.number,
            axisAlignment: MainAxisAlignment.spaceAround,
            style: const BlockInputStyle(
              width: 30,
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(
                        color: Colors.black,
                        width: 1
                    )
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black,
                        width: 2
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(4))
                )
            )
        ),
      ],
    );
  }
}