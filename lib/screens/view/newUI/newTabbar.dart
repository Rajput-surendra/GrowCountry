import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ez/screens/view/newUI/serviceScreenNew.dart';
import 'package:ez/screens/view/newUI/storeScreen.dart';
import 'package:flutter/material.dart';
import 'package:ez/constant/global.dart';
import 'package:ez/screens/view/newUI/profile.dart';
import 'package:ez/screens/view/newUI/booking.dart';
import 'package:ez/screens/view/newUI/home1.dart';
import 'package:ez/share_preference/preferencesKey.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'categoriesScreen.dart';

// ignore: must_be_immutable
class TabbarScreen extends StatefulWidget {
  int? currentIndex;

  @override
  _TabbarScreenState createState() => _TabbarScreenState();
}

class _TabbarScreenState extends State<TabbarScreen> {
  int _currentIndex = 0;
  var _selBottom = 0;

  List<dynamic> _handlePages = [
    HomeScreen(),
    // StoreScreenNew(),
    CategoriesScreen(),
    // StoreScreen(),
    BookingScreen(),
    Profile(),
  ];

  @override
  void initState() {
    getUserDataFromPrefs();

    super.initState();
  }

  getUserDataFromPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userDataStr =
        preferences.getString(SharedPreferencesKey.LOGGED_IN_USERRDATA);
    Map<String, dynamic> userData = json.decode(userDataStr!);
    print(userData);

    setState(() {
      userID = userData['user_id'];
    });
  }

  int currentIndex = 0;
  bool isLoading = false;

  Widget _getBottomNavigator() {
    return Material(
      color: Colors.white,
      //elevation: 2,
      child: CurvedNavigationBar(
        index: currentIndex,
        height: 50,
        backgroundColor: Color(0xfff4f4f4),
        items: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/home.png',
                  height: 25.0,
                  color: _currentIndex == 0 ? backgroundblack : appColorGrey,
                ),
                // Text("Home",
                //   style: TextStyle(
                //     fontWeight: FontWeight.bold, fontSize: 10,
                //     color: currentIndex == 0 ? Colors.black : Colors.grey,
                //   ),
                // )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(
                //   Icons.category,
                //   color: currentIndex == 1 ?  backgroundblack : appColorGrey,),
                Image.asset(
                  'assets/images/category.png',
                  height: 25.0,
                  color: _currentIndex == 1 ?  backgroundblack : appColorGrey,
                ),
                // Text("Category" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,
                //   color: currentIndex == 1 ? Colors.black : Colors.grey,
                // ),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/order.png',
                  height: 25.0,
                  color: _currentIndex == 2 ?  backgroundblack : appColorGrey,
                ),
                // Text("Bookings" , style: TextStyle(
                //   fontWeight: FontWeight.bold,
                //   fontSize: 10,
                //   color: currentIndex == 2 ? Colors.black : Colors.grey,
                // ),)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/profile.png',
                  height: 25.0,
                  color: _currentIndex == 3 ?  backgroundblack : appColorGrey,
                ),
                // Text("Profile" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,
                //   color: currentIndex == 3 ? Colors.black : Colors.grey,
                // ),)
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(4.0),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Icon(Icons.person, size: 25,
          //         color: currentIndex == 4 ? backgroundblack : appColorGrey,
          //       ),
          //       Text("ACCOUNT" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10,
          //         color: currentIndex == 4 ? Colors.black : Colors.grey,
          //       ),)
          //     ],
          //   ),
          // ),
        ],
        onTap: (index) {
          print("current index here ${index}");
          setState(() {
            _currentIndex = index;
            _selBottom = _currentIndex;
            print("sel bottom ${_selBottom}");
            //_pageController.jumpToPage(index);
          });
          // if (currentIndex == 3 ) {
            // if (CUR_USERID == null) {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => Login(),
            //     ),
            //   );
            //   // _pageController.jumpToPage(2);
            // }
          // }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _handlePages[_currentIndex],
      bottomNavigationBar: _getBottomNavigator()
      // ClipRRect(
      //   borderRadius: BorderRadius.only(
      //     topRight: Radius.circular(0),
      //     topLeft: Radius.circular(0),
      //   ),
      //   child: BottomNavigationBar(
      //     selectedIconTheme: IconThemeData(color: backgroundblack),
      //     selectedItemColor: backgroundblack,
      //     selectedFontSize: 12,
      //     unselectedFontSize: 12,
      //     selectedLabelStyle:
      //         TextStyle(fontWeight: FontWeight.bold, color: backgroundblack),
      //     backgroundColor: Colors.white,
      //     type: BottomNavigationBarType.fixed,
      //     currentIndex: _currentIndex,
      //     onTap: (index) {
      //       setState(() {
      //         _currentIndex = index;
      //       });
      //     },
      //     items: <BottomNavigationBarItem>[
      //       _currentIndex == 0
      //           ? BottomNavigationBarItem(
      //               icon: Image.asset(
      //                 'assets/images/home2.png',
      //                 height: 25,
      //                 color: backgroundblack,
      //               ),
      //               label: "Home")
      //           : BottomNavigationBarItem(
      //               icon: Image.asset(
      //                 'assets/images/home.png',
      //                 height: 25,
      //               ),
      //               label: "Home"),
      //      /* _currentIndex == 1
      //           ? BottomNavigationBarItem(
      //               icon: Image.asset(
      //                 'assets/images/service2.png',
      //                 height: 25,
      //                 color: appColorOrange,
      //               ),
      //               label: "Services")
      //           : BottomNavigationBarItem(
      //               icon: Image.asset(
      //                 'assets/images/service1.png',
      //                 height: 25,
      //               ),
      //               label: "Services"),*/
      //       _currentIndex == 1
      //           ? BottomNavigationBarItem(
      //               icon: Icon(
      //                 Icons.category,
      //                 color: backgroundblack,
      //               ),
      //               label: "Category")
      //           : BottomNavigationBarItem(
      //               icon: Icon(
      //                 Icons.category,
      //                 // color: appColorOrange,
      //               ),
      //               label: "Category"),
      //       _currentIndex == 2
      //           ? BottomNavigationBarItem(
      //               icon: Image.asset(
      //                 'assets/images/order2.png',
      //                 height: 25,
      //                 color: backgroundblack,
      //               ),
      //               label: "Bookings")
      //           : BottomNavigationBarItem(
      //               icon: Image.asset(
      //                 'assets/images/order.png',
      //                 height: 25,
      //               ),
      //               label: "Bookings"),
      //       _currentIndex == 3
      //           ? BottomNavigationBarItem(
      //               icon: Image.asset(
      //                 'assets/images/profile2.png',
      //                 height: 25,
      //                 color: backgroundblack,
      //               ),
      //               label: "Profile")
      //           : BottomNavigationBarItem(
      //               icon: Image.asset(
      //                 'assets/images/profile.png',
      //                 height: 25,
      //               ),
      //               label: "Profile"),
      //     ],
      //   ),
      // ),
    );
  }
}
