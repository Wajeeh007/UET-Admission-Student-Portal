import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../widgets/home_page_side_drawer.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(child: Text('Item 1', style: TextStyle(color: Colors.black),), value: 'Item 1',),
    const DropdownMenuItem(child: Text('Item 2', style: TextStyle(color: Colors.black),), value: 'Item 2',),
    const DropdownMenuItem(child: Text('Item 3', style: TextStyle(color: Colors.black)), value: 'Item 3',),
    const DropdownMenuItem(child: Text('Item 4', style: TextStyle(color: Colors.black)), value: 'Item 4',),
    const DropdownMenuItem(child: Text('Item 5', style: TextStyle(color: Colors.black)), value: 'Item 5',),
  ];

  String? dropDownValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height/3.3,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(35), bottomLeft: Radius.circular(35))
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 13),
            child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: (){
                            Navigator.push(context, PageRouteBuilder(opaque: false, pageBuilder: (BuildContext context, _, __){
                              return const sideDrawer();
                            }));
                          },
                          icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 35,)
                      ),
                      const CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.transparent,
                        child: Icon(Icons.account_circle_outlined, size: 35,color: Colors.white,),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Center(
                      child: DropdownButtonFormField(
                        isExpanded: false,
                        decoration: const InputDecoration(
                          hintText: 'Select Merit List',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(29)),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(29)),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1
                              )
                          ),
                        ),
                        items: menuItems,
                        onChanged: (value){
                          setState(() {
                            dropDownValue = value;
                          });
                        },
                        value: dropDownValue,
                      )
                  )
                ]
            ),
          ),
        ),
      ],
    );
  }
}