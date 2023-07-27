import 'dart:convert';

import 'package:ez/screens/view/newUI/detail.dart';
import 'package:ez/screens/view/newUI/labour_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant/global.dart';
import 'package:http/http.dart' as http;

import '../../../models/labour_model.dart';
import '../../../strings/strings.dart';

class ServiceWorkers extends StatefulWidget {
  final title, id;
  const ServiceWorkers({Key? key, this.title, this.id}) : super(key: key);

  @override
  State<ServiceWorkers> createState() => _ServiceWorkersState();
}

class _ServiceWorkersState extends State<ServiceWorkers> {
   LabourModel? labourList ;

  _getProductDetails() async {
    var uri = Uri.parse("$getLabourUrl");
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields['category_id'] = widget.id;
     // request.fields['user_id'] = userID;
    var response = await request.send();
    // print("@@ ${response.statusCode} and ${response.stream.length}");
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if (mounted) {
      setState(() {
        labourList =  LabourModel.fromJson(userData);
        // productDetailsModal = ProductDetailsModal.fromJson(userData);
        // totalPrice = productDetailsModal!.product!.productPrice!;
      });
    }

    print(responseData);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProductDetails();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundblack,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundblack,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: appColorWhite,),
        ),
        title: Text(widget.title, style: TextStyle(
            color: appColorWhite
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
            padding: EdgeInsets.only(top: 30),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: appColorWhite,
                borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30),)
            ),
            // child: ListView.builder(
            //   padding: EdgeInsets.only(
            //     bottom: 10,
            //     top: 0,
            //   ),
            //   itemCount: services.length,
            //   scrollDirection: Axis.vertical,
            //   itemBuilder: (context, int index,) {
            //     return Padding(
            //       padding: const EdgeInsets.only(bottom: 15.0, left: 20, right: 20),
            //       child: InkWell(
            //         onTap: () {
            //           Navigator.push(context, MaterialPageRoute(builder: (context) => AllProviderService(catid: "0",)));
            //           // Navigator.push(
            //           //   context,
            //           //   MaterialPageRoute(
            //           //       builder: (context) =>
            //           //           SubCategoryScreen(id: categories.id!, name: categories.cName!,image: categories.img,description: categories.description,)
            //           //     // ViewCategory(id: categories.id!, name: categories.cName!)
            //           //   ),
            //           // );
            //         },
            //         child: Container(
            //           padding: EdgeInsets.only(left: 10, right: 15),
            //           width: 200,
            //           height: 80,
            //           decoration: BoxDecoration(
            //               border: Border.all(color: backgroundblack),
            //               borderRadius: BorderRadius.circular(10)
            //           ),
            //           // elevation: 3,
            //           // shape: RoundedRectangleBorder(
            //           //   borderRadius: BorderRadius.circular(10),
            //           // ),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Row(
            //                 // mainAxisAlignment: MainAxisAlignment.center,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: [
            //                   Padding(
            //                     padding: const EdgeInsets.only(left: 10.0, right: 12),
            //                     child: Container(
            //                       // width: 120,
            //                       height: 50,
            //                       child: ClipRRect(
            //                         borderRadius: BorderRadius.circular(5),
            //                         child: Image.asset(
            //                           services[index]['image'],
            //                           fit: BoxFit.contain,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   Container(
            //                     width: 120,
            //                     child: Text(
            //                       services[index]['name'],
            //
            //                       style: TextStyle(
            //                           color: backgroundblack,
            //                           fontSize: 16,
            //                           fontWeight: FontWeight.normal),
            //                       maxLines: 2,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               Icon(Icons.arrow_forward_ios_outlined,
            //                 color: backgroundblack,)
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //
            //     // sortingCard(
            //     //   context, collectionModal!.categories![index]);
            //   },
            // )
          child: labourList != null ?
          FutureBuilder(
            future: _getProductDetails(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.hasError) {
                return CircularProgressIndicator();
              } else{
                if (labourList!.labour!.length != 0) {
                  return GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.all(10),
                    itemCount: labourList!.labour!.length != "" ? labourList!
                        .labour!.length : 0,
                    //10,
                    //collectionModal!.categories!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 15.0,
                      childAspectRatio: 250 / 290,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => LabourDetail(
                                  model: labourList!.labour![index],
                                )));
                            // Navigator.push(
                            //   context,
                            //   CupertinoPageRoute(
                            //     builder: (context) => ViewCategory(
                            //       id: collectionModal!.categories![index].id,
                            //       name: collectionModal!.categories![index].cName!,
                            //       catId: widget.id,
                            //       fromSeller: false,
                            //     ),
                            //   ),
                            // );
                          },
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            child: Column(

                              children: [
                                Container(
                                  height: 120,
                                  width: 120,
                                  alignment: Alignment.topCenter,
                                  decoration: BoxDecoration(
                                    color: Colors.black45,
                                    borderRadius: BorderRadius.circular(100),
                                    // only(
                                    //     topLeft: Radius.circular(10),
                                    //     topRight: Radius.circular(10)),
                                    image: DecorationImage(
                                      image: NetworkImage( "${labourList!.labour![index].profileImage}",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "${labourList!.labour![index].uname}",
                                    // collectionModal!.categories![index].cName![0].toUpperCase() + collectionModal!.categories![index].cName!.substring(1),
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: appColorBlack,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                // Card(
                                //   elevation: 5,
                                //   shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(20),
                                //   ),
                                //   child: Container(
                                //     width: 180,
                                //     child: Padding(
                                //       padding: const EdgeInsets.only(
                                //           bottom: 15, left: 15, right: 5),
                                //       child: Column(
                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                //         mainAxisAlignment: MainAxisAlignment.end,
                                //         children: [
                                //           Text(
                                //             collectionModal!.categories![index].cName!,
                                //             maxLines: 1,
                                //             style: TextStyle(
                                //                 color: appColorBlack,
                                //                 fontSize: 14,
                                //                 fontWeight: FontWeight.bold),
                                //           ),
                                //           Container(height: 10),
                                //           /*Row(
                                //             mainAxisAlignment:
                                //             MainAxisAlignment.spaceBetween,
                                //             crossAxisAlignment:
                                //             CrossAxisAlignment.end,
                                //             children: [
                                //               Column(
                                //                 crossAxisAlignment:
                                //                 CrossAxisAlignment.start,
                                //                 children: [
                                //                   Container(
                                //                     width: 110,
                                //                     child: Text(
                                //                       catModal!.restaurants![index].resDesc!,
                                //                       maxLines: 2,
                                //                       overflow: TextOverflow.ellipsis,
                                //                       style: TextStyle(
                                //                           color: appColorBlack,
                                //                           fontSize: 12,
                                //                           fontWeight: FontWeight.normal),
                                //                     ),
                                //                   ),
                                //                   Text(
                                //                     "₹" + catModal!.restaurants![index].price!,
                                //                     style: TextStyle(
                                //                         color: appColorBlack,
                                //                         fontSize: 16,
                                //                         fontWeight: FontWeight.bold),
                                //                   ),
                                //                   Container(
                                //                     child: Padding(
                                //                         padding: EdgeInsets.all(0),
                                //                         child: Text(
                                //                           "BOOK NOW",
                                //                           style: TextStyle(
                                //                               color: Colors.blue,
                                //                               fontSize: 12),
                                //                         )),
                                //                   ),
                                //                 ],
                                //               ),
                                //
                                //             ],
                                //           ),*/
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // Container(
                                //   height: 100,
                                //   width: 140,
                                //   alignment: Alignment.topCenter,
                                //   decoration: BoxDecoration(
                                //     color: Colors.black45,
                                //     borderRadius: BorderRadius.circular(10),
                                //     image: DecorationImage(
                                //       image: NetworkImage(collectionModal!.categories![index].img!),
                                //       fit: BoxFit.cover,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                      child: Text("${labourList!.msg.toString()}",
                  style: TextStyle(
                    color: appColorBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),));
                }

              }
              //   labourList != null ?
              //
              //
              // : Container(
              //   height: 40,
              //     width: 40,
              //     child: CircularProgressIndicator());
            }
          )
          : Center(
            child: Container(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: backgroundblack,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
