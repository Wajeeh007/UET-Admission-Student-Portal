import 'package:flutter/material.dart';
import 'package:online_admission/constants.dart';

class PreviousMeritLists extends StatefulWidget {

  const PreviousMeritLists({super.key});

  @override
  State<PreviousMeritLists> createState() => _PreviousMeritListsState();
}

class _PreviousMeritListsState extends State<PreviousMeritLists> {

  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: 'Item 1',child: Text('Item 1'),),
    const DropdownMenuItem(value: 'Item 2',child: Text('Item 2'),),
    const DropdownMenuItem(value: 'Item 3',child: Text('Item 3'),),
    const DropdownMenuItem(value: 'Item 4',child: Text('Item 4'),),
    const DropdownMenuItem(value: 'Item 5',child: Text('Item 5'),),
  ];

  String? dropDownValue;
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: const Padding(
              padding: EdgeInsets.only(top: 26.0),
              child: Text(
                'Previous Merits',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: IconButton(
                onPressed: ()=>Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_rounded, size: 36, color: Colors.black,),
              ),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 25),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0, bottom: 8),
                child: Text(
                  'Search Department',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 15
                  ),
                ),
              ),
            ),
            DropdownButtonFormField(
              isDense: true,
              icon: const Icon(Icons.keyboard_arrow_down, size: 30, color: Colors.white,),
              items: menuItems,
              onChanged: (value){
                setState(() {
                  dropDownValue = value;
                  if(isSelected == false){
                    isSelected = true;
                  }
                });
              },
              value: dropDownValue,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
              decoration: const InputDecoration(
                hintText: 'Select Department',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                fillColor: primaryColor,
                filled: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(29)),
                    borderSide: BorderSide(
                        color: primaryColor,
                        width: 0
                    )
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(29)),
                  borderSide: BorderSide(
                      color: primaryColor,
                      width: 0
              ),
            ),
              ),
            ),
            isSelected ? Container() : const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text('Select a department to show previous merits', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
