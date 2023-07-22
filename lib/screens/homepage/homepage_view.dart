import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_admission/screens/base/base_layout_viewmodel.dart';
import 'package:online_admission/screens/homepage/homepage_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../../functions/google_and_facebook_auth.dart';
import '../complain/complain_view.dart';
import '../loginsignupscreens/choose_login_or_signup.dart';
import '../menu_screens/merit_list.dart';

class HomePage extends StatefulWidget{

  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>with TickerProviderStateMixin {
  final HomePageViewModel viewModel = Get.put(HomePageViewModel());

  late AnimationController animationController1 = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
  late Animation<Offset> animation = Tween<Offset>(begin: Offset.zero, end: const Offset(0.4, 0.28)).animate(animationController1);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color(0xffd0874c),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 45,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => Text(
                        viewModel.userName.value,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700
                        ),),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/2.2,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: Image.asset('assets/images/complain_icon.png', width: 30, height: 30,),
                      title: const Text('Complains', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14, fontFamily: 'Poppins')),
                      onTap: (){
                        Get.to(() => ComplainScreen());
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.history, color: Colors.white, size: 27,),
                      title: const Text('Merit History', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14, fontFamily: 'Poppins')),
                      onTap: (){
                        Get.to(() => const PreviousMeritLists());
                      },
                    ),
                    ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: Image.asset('assets/images/logout_icon.png', width: 23, height: 23,),
                      ),
                      title: const Text('Logout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14, fontFamily: 'Poppins')),
                      onTap: ()async{
                        SharedPreferences prefs =  await SharedPreferences.getInstance();
                        var isGoogleUser = await prefs.getBool('isGoogleSignIn');
                        BaseLayoutViewModel baseLayoutViewModel = Get.find();
                        if(isGoogleUser == true){
                          await prefs.clear();
                          await GoogleLogIn().googleSignOut();
                          viewModel.angle.value = 0.0;
                          viewModel.meritListVisibilty.value = false;
                          viewModel.transformContainer.value = false;
                          baseLayoutViewModel.bottomNavBarVisibility.value = true;
                          viewModel.fieldName.value = 'Search fields merit here';
                          Get.offAll(() => const AuthChoose());
                        } else{
                          await prefs.clear();
                          viewModel.angle.value = 0.0;
                          viewModel.meritListVisibilty.value = false;
                          baseLayoutViewModel.bottomNavBarVisibility.value = true;
                          viewModel.transformContainer.value = false;
                          viewModel.fieldName.value = 'Search fields merit here';
                          Get.offAll(()=> const AuthChoose());
                        }
                      },
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    ListTile(
                      leading: const Icon(Icons.arrow_back, color: Colors.white, size: 25,),
                      title: const Text('Back', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14, fontFamily: 'Poppins')),
                      onTap: (){
                        BaseLayoutViewModel baseLayoutViewModel = Get.find();
                        viewModel.transformContainer.value = false;
                        viewModel.angle.value = 0.0;
                        animationController1.reverse();
                        animationController1.addListener(() {
                          setState(() {
                            animation.value;
                          });
                        });
                        Future.delayed(const Duration(milliseconds: 550), (){
                          baseLayoutViewModel.bottomNavBarVisibility.value = true;
                        });
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        SlideTransition(
          position: animation,
          child: Obx(() => Transform.rotate(
              angle: viewModel.angle.value,
              child: AnimatedContainer(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: viewModel.transformContainer.value ? const BorderRadius.only(topRight: Radius.circular(35), topLeft: Radius.circular(35)) : null,
                ),
                duration: const Duration(milliseconds: 400),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Obx(() => Container(
                            height: MediaQuery.of(context).size.height/3.3,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: viewModel.transformContainer.value ? const BorderRadius.all(Radius.circular(35)) : const BorderRadius.only(bottomRight: Radius.circular(35), bottomLeft: Radius.circular(35))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 13),
                              child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                            onTap: (){
                                              BaseLayoutViewModel baseLayoutViewModel = Get.find();
                                              if(viewModel.transformContainer.value == true){
                                                return;
                                              }
                                              else{
                                                baseLayoutViewModel.bottomNavBarVisibility.value = false;
                                                viewModel.transformContainer.value = true;
                                                viewModel.angle.value = -270.0;
                                                animationController1.forward();
                                                animationController1.addListener(() {
                                                  setState(() {
                                                    animation.value;
                                                  });
                                                });
                                              }
                                            },
                                            child: Image.asset('assets/images/menu_icon.png', width: 23, height: 23,),
                                        ),
                                        const CircleAvatar(
                                          radius: 26,
                                          backgroundColor: Colors.transparent,
                                          child: Icon(Icons.account_circle_outlined, size: 35,color: Colors.white,),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                        height: 42,
                                      ),
                                    Obx(() => Center(
                                      child: DropdownButtonFormField(
                                        value: viewModel.fieldName.value,
                                        isExpanded: false,
                                          items: viewModel.fields,
                                          onChanged: (value)async{
                                            if(value == viewModel.fields[0].value){
                                              showToast('Choose Department');
                                            } else{
                                              viewModel.fieldName.value = value.toString();
                                             await viewModel.getMeritList();
                                            }
                                          },
                                        decoration: const InputDecoration(
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
                                      ),
                                    ),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Obx(() => Visibility(
                              visible: viewModel.meritListVisibilty.value,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 25),
                                child: Container(
                                  height: MediaQuery.of(context).size.height/1.97,
                                  width: MediaQuery.of(context).size.width/1.1,
                                  padding: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color(0xffd1d3da),
                                      width: 0.8,
                                    ),
                                    borderRadius: const BorderRadius.all(Radius.circular(12))
                                  ),///
                                  child: Stack(
                                    fit: StackFit.loose,
                                    children: [
                                      SingleChildScrollView(
                                        physics: const ScrollPhysics(),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                  color: Color(0xffd1d3da),
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  meritListHeading('ETEA Id'),
                                                  meritListHeading('Name'),
                                                  meritListHeading('F/Name'),
                                                  meritListHeading('Aggregate'),
                                                  meritListHeading('Eligibility'),
                                                ],
                                              )
                                            ),
                                            ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: viewModel.meritList.length,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index){
                                                return Padding(
                                                  padding: const EdgeInsets.only(top: 12.0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          meritListText(viewModel.meritList[index].meritNumber.toString(), 31),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 10.0),
                                                            child: meritListText(viewModel.meritList[index].studentName.toString(), 40),
                                                          ),
                                                          meritListText(viewModel.meritList[index].fatherName.toString(), 38),
                                                          Padding(
                                                            padding: const EdgeInsets.only(right: 10.0),
                                                            child: meritListText(viewModel.meritList[index].aggregate.toString(), 34),
                                                          ),
                                                          meritListText(viewModel.meritList[index].eligibility.toString(), 25),
                                                            ],
                                                      ),
                                                      const Divider(
                                                        color: Color(0xffd1d3da),
                                                        thickness: 1.5,
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        left: 60,
                                        child: Container(
                                          color: const Color(0xffd1d3da),
                                          width: 1.5,
                                          height: MediaQuery.of(context).size.height/1.97,
                                        ),
                                      ),
                                      Positioned(
                                        left: 128,
                                        child: Container(
                                          color: const Color(0xffd1d3da),
                                          width: 1.5,
                                          height: MediaQuery.of(context).size.height/1.97,
                                        ),
                                      ),
                                      Positioned(
                                        right: 135,
                                        child: Container(
                                          color: const Color(0xffd1d3da),
                                          width: 1.5,
                                          height: MediaQuery.of(context).size.height/1.97,
                                        ),
                                      ),
                                      Positioned(
                                        right: 63,
                                        child: Container(
                                          color: const Color(0xffd1d3da),
                                          width: 1.5,
                                          height: MediaQuery.of(context).size.height/1.97,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  meritListHeading(String heading){
    return SizedBox(
      width: 58,
      child: Center(
        child: Text(
          heading,
          style: const TextStyle(
              color: Color(0xff435060),
              fontWeight: FontWeight.w700,
              fontFamily: 'Poppins',
              fontSize: 10
          ),
        ),
      ),
    );
  }

  meritListText(String text, double width){
    return SizedBox(
      width: width,
      child: Text(
        text,
        maxLines: 2,
        overflow: TextOverflow.fade,
        style: const TextStyle(
            color: Color(0xff435060),
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
          fontSize: 8
        ),
      ),
    );
  }
}