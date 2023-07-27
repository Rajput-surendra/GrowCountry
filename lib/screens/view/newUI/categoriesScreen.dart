import 'dart:convert';
import 'package:ez/screens/view/models/categories_model.dart';
import 'package:ez/screens/view/newUI/book_delivery.dart';
import 'package:ez/screens/view/newUI/sub_category.dart';
import 'package:ez/screens/view/newUI/subcat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez/constant/global.dart';
import 'package:ez/constant/sizeconfig.dart';
import 'package:ez/screens/view/newUI/viewCategory.dart';
import 'package:http/http.dart' as http;

import '../../../strings/strings.dart';


class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<CategoriesScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  AllCateModel? collectionModal;

  @override
  void initState() {
    _getCollection();
    super.initState();
  }

  _getCollection() async {
    var uri = Uri.parse('$getCategoryUrl');
    var request = new http.MultipartRequest("GET", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if (mounted) {
      setState(() {
        collectionModal = AllCateModel.fromJson(userData);
      });
    }

    print(responseData);
  }

  Future<Null> refreshFunction()async{
    await _getCollection();

  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: backgroundblack,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundblack,
        // leading: IconButton(
        //   onPressed: (){
        //     Navigator.pop(context);
        //   },
        //   icon: Icon(Icons.arrow_back_ios, color: appColorWhite,),
        // ),
        title: Text("Categories", style: TextStyle(
            color: appColorWhite
        ),),
      ),
      body: Container(
          padding: EdgeInsets.only(top: 30),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: appColorWhite,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30),)
          ),
          child:  Padding(
              padding: const EdgeInsets.only( left: 40, right: 40, bottom: 20),
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SubCategory(
                        title: "Labour Service",
                      )));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: backgroundblack),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // height:100,
                            // width: 150,
                            child: Image.asset("assets/images/labour.png",fit:BoxFit.fill,),
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10),),
                                color: backgroundblack
                            ),
                            child: Center(
                              child: Text("Labour Service",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: appColorWhite
                                ),),
                            ),
                          )
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 3),
                          //   child: Text("${destinationModel!.data![i].name}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 16),),
                          // ),
                          // SizedBox(height: 4,),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 3),
                          //   child: Text("${destinationModel!.data![i].description}",style: TextStyle(height: 1.1,color: appColorBlack.withOpacity(0.5),fontSize: 13),maxLines: 2,),
                          // ),
                          // SizedBox(height: 3,),
                          // Divider(height: 1,),
                          // SizedBox(height: 2,),
                          // Padding(
                          //   padding:EdgeInsets.only(left: 3),
                          //   child: Row(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text("View More",style: TextStyle(color: backgroundblack,fontWeight: FontWeight.w600,fontSize: 13),),
                          //       SizedBox(width: 5,),
                          //       Icon(Icons.arrow_forward_rounded,color: backgroundblack,size: 20,),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> BookDeliveryService(
                      )));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: backgroundblack),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            // height:100,
                            // width: 144,
                            child: Image.asset("assets/images/delivery.png",fit:BoxFit.fill,),
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10),),
                                color: backgroundblack
                            ),
                            child: Center(
                              child: Text("Delivery Service",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: appColorWhite
                                ),),
                            ),
                          )
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 3),
                          //   child: Text("${destinationModel!.data![i].name}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 16),),
                          // ),
                          // SizedBox(height: 4,),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 3),
                          //   child: Text("${destinationModel!.data![i].description}",style: TextStyle(height: 1.1,color: appColorBlack.withOpacity(0.5),fontSize: 13),maxLines: 2,),
                          // ),
                          // SizedBox(height: 3,),
                          // Divider(height: 1,),
                          // SizedBox(height: 2,),
                          // Padding(
                          //   padding:EdgeInsets.only(left: 3),
                          //   child: Row(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text("View More",style: TextStyle(color: backgroundblack,fontWeight: FontWeight.w600,fontSize: 13),),
                          //       SizedBox(width: 5,),
                          //       Icon(Icons.arrow_forward_rounded,color: backgroundblack,size: 20,),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              )

            // ListView.builder(
            //   scrollDirection: Axis.vertical,
            //   shrinkWrap: true,
            //   //physics: const NeverScrollableScrollPhysics(),
            //   itemCount: collectionModal!.categories!.length,
            //   itemBuilder: (context, int index) {
            //     return widgetCatedata(
            //         collectionModal!.categories![index]);
            //   },
            // ),
          )
      ),
    );

    //   Scaffold(
    //     backgroundColor: Color(0xffF5F5F5),
    //     appBar: AppBar(
    //       automaticallyImplyLeading: false,
    //       // leading:  Padding(
    //       //   padding: const EdgeInsets.all(12),
    //       //   child: RawMaterialButton(
    //       //     shape: CircleBorder(),
    //       //     padding: const EdgeInsets.all(0),
    //       //     fillColor: Colors.white,
    //       //     splashColor: Colors.grey[400],
    //       //     child: Icon(
    //       //       Icons.arrow_back,
    //       //       size: 20,
    //       //       color: appColorBlack,
    //       //     ),
    //       //     onPressed: () {
    //       //       Navigator.pop(context);
    //       //     },
    //       //   ),
    //       // ),
    //       backgroundColor: backgroundblack,
    //       elevation: 2,
    //       shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.only(
    //               bottomLeft: Radius.circular(20),
    //               bottomRight: Radius.circular(20)
    //           )
    //       ),
    //       title: Text(
    //         'Categories',
    //         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    //       ),
    //       centerTitle: true,
    //     ),
    //     body: RefreshIndicator(
    //       onRefresh: refreshFunction,
    //       child:
    //       // collectionModal == null
    //       //     ? Center(
    //       //   child:  Container(
    //                             height: 30,
    //                               width: 30,
    //                             child: CircularProgressIndicator(
    //                               color: backgroundblack,
    //                             ),
    //                           )
    //       // )
    //       //     : collectionModal!.categories!.length > 0
    //       //     ?
    //       Padding(
    //         padding: const EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 25),
    //         child: Column(
    //           children: [
    //             InkWell(
    //               onTap: (){
    //                 Navigator.push(context, MaterialPageRoute(builder: (context)=> SubCategory(
    //                   title: "Labour Service",
    //                 )));
    //               },
    //               child: Container(
    //                 width: MediaQuery.of(context).size.width,
    //                 decoration: BoxDecoration(
    //                     border: Border.all(color: backgroundblack),
    //                     borderRadius: BorderRadius.circular(12)
    //                 ),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Container(
    //                       // height:100,
    //                       // width: 150,
    //                       child: Image.asset("assets/images/labour.png",fit:BoxFit.fill,),
    //                     ),
    //                     Container(
    //                       height: 60,
    //                       width: double.infinity,
    //                       decoration: BoxDecoration(
    //                           borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10),),
    //                           color: backgroundblack
    //                       ),
    //                       child: Center(
    //                         child: Text("Labour Service",
    //                           style: TextStyle(
    //                               fontSize: 20,
    //                               color: appColorWhite
    //                           ),),
    //                       ),
    //                     )
    //                     // Padding(
    //                     //   padding: EdgeInsets.symmetric(horizontal: 3),
    //                     //   child: Text("${destinationModel!.data![i].name}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 16),),
    //                     // ),
    //                     // SizedBox(height: 4,),
    //                     // Padding(
    //                     //   padding: EdgeInsets.symmetric(horizontal: 3),
    //                     //   child: Text("${destinationModel!.data![i].description}",style: TextStyle(height: 1.1,color: appColorBlack.withOpacity(0.5),fontSize: 13),maxLines: 2,),
    //                     // ),
    //                     // SizedBox(height: 3,),
    //                     // Divider(height: 1,),
    //                     // SizedBox(height: 2,),
    //                     // Padding(
    //                     //   padding:EdgeInsets.only(left: 3),
    //                     //   child: Row(
    //                     //     crossAxisAlignment: CrossAxisAlignment.start,
    //                     //     children: [
    //                     //       Text("View More",style: TextStyle(color: backgroundblack,fontWeight: FontWeight.w600,fontSize: 13),),
    //                     //       SizedBox(width: 5,),
    //                     //       Icon(Icons.arrow_forward_rounded,color: backgroundblack,size: 20,),
    //                     //     ],
    //                     //   ),
    //                     // ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             SizedBox(height: 40,),
    //             InkWell(
    //               onTap: (){
    //                 Navigator.push(context, MaterialPageRoute(builder: (context)=> BookDeliveryService(
    //                 )));
    //               },
    //               child: Container(
    //                 width: MediaQuery.of(context).size.width,
    //                 decoration: BoxDecoration(
    //                     border: Border.all(color: backgroundblack),
    //                     borderRadius: BorderRadius.circular(12)
    //                 ),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Container(
    //                       padding: EdgeInsets.only(right: 10),
    //                       // height:100,
    //                       // width: 144,
    //                       child: Image.asset("assets/images/delivery.png",fit:BoxFit.fill,),
    //                     ),
    //                     Container(
    //                       height: 60,
    //                       width: double.infinity,
    //                       decoration: BoxDecoration(
    //                           borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10),),
    //                           color: backgroundblack
    //                       ),
    //                       child: Center(
    //                         child: Text("Delivery Service",
    //                           style: TextStyle(
    //                               fontSize: 20,
    //                               color: appColorWhite
    //                           ),),
    //                       ),
    //                     )
    //                     // Padding(
    //                     //   padding: EdgeInsets.symmetric(horizontal: 3),
    //                     //   child: Text("${destinationModel!.data![i].name}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 16),),
    //                     // ),
    //                     // SizedBox(height: 4,),
    //                     // Padding(
    //                     //   padding: EdgeInsets.symmetric(horizontal: 3),
    //                     //   child: Text("${destinationModel!.data![i].description}",style: TextStyle(height: 1.1,color: appColorBlack.withOpacity(0.5),fontSize: 13),maxLines: 2,),
    //                     // ),
    //                     // SizedBox(height: 3,),
    //                     // Divider(height: 1,),
    //                     // SizedBox(height: 2,),
    //                     // Padding(
    //                     //   padding:EdgeInsets.only(left: 3),
    //                     //   child: Row(
    //                     //     crossAxisAlignment: CrossAxisAlignment.start,
    //                     //     children: [
    //                     //       Text("View More",style: TextStyle(color: backgroundblack,fontWeight: FontWeight.w600,fontSize: 13),),
    //                     //       SizedBox(width: 5,),
    //                     //       Icon(Icons.arrow_forward_rounded,color: backgroundblack,size: 20,),
    //                     //     ],
    //                     //   ),
    //                     // ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         )
    //
    //         // ListView.builder(
    //         //   scrollDirection: Axis.vertical,
    //         //   shrinkWrap: true,
    //         //   //physics: const NeverScrollableScrollPhysics(),
    //         //   itemCount: collectionModal!.categories!.length,
    //         //   itemBuilder: (context, int index) {
    //         //     return widgetCatedata(
    //         //         collectionModal!.categories![index]);
    //         //   },
    //         // ),
    //       )
    //       //     : Center(
    //       //   child: Text(
    //       //     "Don't have any categories now",
    //       //     style: TextStyle(
    //       //       color: Colors.white,
    //       //       fontStyle: FontStyle.italic,
    //       //     ),
    //       //   ),
    //       // ),
    //     ),
    // );
  }

  Widget widgetCatedata(Categories categories) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SubCategoryScreen(id: categories.id!, name: categories.cName!,image: categories.img,description: categories.description, )
            // ViewCategory(id: categories.id!, name: categories.cName!)
          ),
        );
        // Navigator.push(
        //   context,
        //   CupertinoPageRoute(
        //     builder: (context) => ViewCategory(
        //       id: categories.id!,
        //       name: categories.cName!,
        //     ),
        //   ),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
        child: new Card(
          elevation: 1,
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Row(
              children: <Widget>[
                Container(width: 20),
                Container(
                    height: 70,
                    width: 100 ,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        categories.img!,
                        fit: BoxFit.cover,
                        // color: appColorWhite,
                      ),
                    )),
                Container(width: 20),
                Container(
                  width: 160,
                  child: Text(
                    categories.cName!,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'OpenSansBold',
                        fontWeight: FontWeight.bold,
                        color: appColorBlack),
                  ),
                ),
                Container(width: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
