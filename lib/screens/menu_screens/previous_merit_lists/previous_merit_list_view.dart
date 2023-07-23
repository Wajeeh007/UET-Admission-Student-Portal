import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:online_admission/constants.dart';
import 'package:online_admission/screens/menu_screens/merit_list/merit_list_view.dart';
import 'package:online_admission/screens/menu_screens/previous_merit_lists/previous_merit_list_viewmodel.dart';

class PreviousMeritLists extends StatelessWidget {

  PreviousMeritLists({super.key});

  final PreviousMeritListViewModel viewModel = Get.put(PreviousMeritListViewModel());

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
                    color: Color(0xff435060),
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.only(top: 17.0),
              child: IconButton(
                onPressed: ()=>Get.back(),
                icon: const Icon(Icons.arrow_back_rounded, size: 36, color: Color(0xff435060),),
              ),
            ),
          )),
      body: Obx(()=> LoadingOverlay(
          isLoading: viewModel.overlay.value,
          color: Colors.black54,
          progressIndicator: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 6.5,
          ),
          child: Padding(
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
                        color: Color(0xff435060),
                        fontWeight: FontWeight.w700,
                        fontSize: 15
                      ),
                    ),
                  ),
                ),
                DropdownButtonFormField(
                  isDense: true,
                  icon: const Icon(Icons.keyboard_arrow_down, size: 30, color: Colors.white,),
                  items: viewModel.menuItems,
                  onChanged: (value)async{
                    if(value == viewModel.menuItems[0].value){
                      showToast('Choose Correct Department');
                    } else {
                      viewModel.departmentName.value = value.toString();
                      await viewModel.getPreviousMerits();
                    }
                    },
                  dropdownColor: Color(0xffd0874c),
                  value: viewModel.departmentName.value,
                  decoration: const InputDecoration(
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
                SizedBox(
                  height: 20,
                ),
                Obx(() => ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: viewModel.downloadLinks1.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Color(0xfff8f6f4),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  viewModel.downloadLinks1.entries.elementAt(index).key,
                                  style: TextStyle(
                                    color: Color(0xff29384d),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                TextButton(
                                    onPressed: (){
                                      Get.to(() => MeritListView(), opaque: false, arguments: [{
                                        'listLink': viewModel.downloadLinks1.entries.elementAt(index).value,
                                      }]);
                                    },
                                    child: Text(
                                      'View',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff29384d),
                                        decoration: TextDecoration.underline
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}