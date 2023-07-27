import 'dart:convert';
import 'package:dotted_line/dotted_line.dart';
import 'package:ez/models/booking_model.dart';
import 'package:ez/screens/view/newUI/delivery_booking_details.dart';
import 'package:ez/screens/view/newUI/labour_booking_details.dart';
import 'package:ez/screens/view/newUI/viewOrders.dart';
import 'package:ez/strings/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez/constant/global.dart';
import 'package:ez/constant/sizeconfig.dart';
import 'package:ez/screens/view/models/getBookingModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ticketview/ticketview.dart';
// import 'package:toast/toast.dart';

// ignore: must_be_immutable
class BookingScreen extends StatefulWidget {
  bool? back;
  BookingScreen({this.back});
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<BookingScreen> {
  bool explorScreen = false;
  bool mapScreen = true;
  // GetBookingModel? model;
  // GetOrdersModal? getOrdersModal;
  BookingModel? getBookingData;

  @override
  void initState() {
    getOrderApi();
    super.initState();
    getBookingAPICall();
  }

  getOrderApi() async {
    try {
      Map<String, String> headers = {
        'content-type': 'application/x-www-form-urlencoded',
      };
      var map = new Map<String, dynamic>();
      map['user_id'] = userID;

      final response = await client.post(Uri.parse("$getBookingsUrl"),
          headers: headers, body: map);

      Map<String, dynamic> userMap = jsonDecode(response.body);
      setState(() {
        getBookingData = BookingModel.fromJson(userMap);
      });
    } on Exception {
      Fluttertoast.showToast(msg: "No Internet connection");
      throw Exception('No Internet connection');
    }
  }

  getBookingAPICall() async {

      Map<String, String> headers = {
        'content-type': 'application/x-www-form-urlencoded',
      };
      var map = new Map<String, dynamic>();
      map['user_id'] = userID;

      final response = await client.post(Uri.parse("$getBookingsUrl"),
          headers: headers, body: map);

      var dic = json.decode(response.body);

      Map<String, dynamic> userMap = jsonDecode(response.body);
      setState(() {
        getBookingData = BookingModel.fromJson(userMap);
      });
      print("GetBooking>>>>>>");
      print(dic);
    // } on Exception {
    //   Fluttertoast.showToast(msg: "No Internet connection");
    //   throw Exception('No Internet connection');
    // }
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
        title: Text("My Bookings", style: TextStyle(
            color: appColorWhite
        ),),
      ),
      body: Container(
          padding: EdgeInsets.only(top: 30),
          // height: MediaQuery.of(context).size.height-120,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: appColorWhite,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30),)
          ),
          child:  Container(
            child: Column(
              children: [
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    initialIndex: 0,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: appColorWhite),
                            child: Center(
                              child: TabBar(
                                labelColor: backgroundblack,
                                unselectedLabelColor: appColorGrey,
                                labelStyle: TextStyle(
                                    fontSize: 18.0,
                                    color: backgroundblack,
                                    fontWeight: FontWeight.w500),
                                unselectedLabelStyle: TextStyle(
                                    fontSize: 18.0,
                                    color: appColorBlack,
                                    fontWeight: FontWeight.normal),
                                indicator: UnderlineTabIndicator(
                                  borderSide: const BorderSide(
                                    width: 2.5,
                                      color: backgroundblack)
                                ),
                                // BoxDecoration(
                                //     borderRadius: BorderRadius.circular(8),
                                //     color: Color(0xFF619aa5)),
                                tabs: <Widget>[
                                  Tab(
                                    text: 'Labour Service',
                                  ),
                                  Tab(
                                    text: 'Delivery Service',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: <Widget>[
                              labourWidget(),
                              deliveryWidget()
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );


    //   Scaffold(
    //   backgroundColor: appColorWhite,
    //   appBar: AppBar(
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.only(
    //             bottomLeft: Radius.circular(20),
    //             bottomRight: Radius.circular(20)
    //         )
    //     ),
    //     backgroundColor: backgroundblack,
    //     elevation: 0,
    //     title: Text(
    //       'My Bookings',
    //       style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    //     ),
    //     centerTitle: true,
    //     leading: widget.back == true
    //         ?   Padding(
    //       padding: const EdgeInsets.all(12),
    //       child: RawMaterialButton(
    //         shape: CircleBorder(),
    //         padding: const EdgeInsets.all(0),
    //         fillColor: Colors.white,
    //         splashColor: Colors.grey[400],
    //         child: Icon(
    //           Icons.arrow_back,
    //           size: 20,
    //           color: appColorBlack,
    //         ),
    //         onPressed: () {
    //           Navigator.pop(context);
    //         },
    //       ),
    //     )
    //         : Container(),
    //   ),
    //   body: Container(
    //     child: Column(
    //       children: [
    //         Expanded(
    //           child: DefaultTabController(
    //             length: 1,
    //             initialIndex: 0,
    //             child: Column(
    //               children: <Widget>[
    //                 Container(
    //                   width: 250,
    //                   height: 40,
    //                   decoration: new BoxDecoration(
    //                       borderRadius: BorderRadius.circular(8),
    //                       color: Colors.grey[300]),
    //                   child: Center(
    //                     child: TabBar(
    //                       labelColor: appColorWhite,
    //                       unselectedLabelColor: appColorBlack,
    //                       labelStyle: TextStyle(
    //                           fontSize: 13.0,
    //                           color: appColorWhite,
    //                           fontWeight: FontWeight.bold),
    //                       unselectedLabelStyle: TextStyle(
    //                           fontSize: 13.0,
    //                           color: appColorBlack,
    //                           fontWeight: FontWeight.bold),
    //                       indicator: BoxDecoration(
    //                           borderRadius: BorderRadius.circular(8),
    //                           color: Color(0xFF619aa5)),
    //                       tabs: <Widget>[
    //                         // Tab(
    //                         //   text: 'Orders',
    //                         // ),
    //                         Tab(
    //                           text: 'Booking',
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 Expanded(
    //                   child: TabBarView(
    //                     children: <Widget>[
    //                       // orderWidget(),
    //                       bookingWidget()
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  // _refresh(){
  //   getBookingAPICall();
  // }

  Widget labourWidget() {
    return getBookingData == null
        ? Center(
            child: Container()
          )
        : getBookingData!.responseCode != "0"
            ? ListView.builder(
                // padding: EdgeInsets.only(bottom: 10, top: 10),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                //physics: const NeverScrollableScrollPhysics(),
                itemCount: getBookingData!.data!.labourRequests!.length,
                    // .orders!.length,
                //scrollDirection: Axis.horizontal,
                itemBuilder: (
                  context,
                  int index,
                ) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewOrders(
                                  // orders: getBookingData!.data!.labourRequests![index].id
                                  // getOrdersModal!.orders![index]
                              )),
                        );
                      },
                      child: TicketView(
                          drawShadow: true,
                          backgroundColor: appColorWhite,
                          drawArc: true,
                          triangleAxis: Axis.horizontal,
                          borderRadius: 6,
                          triangleSize: Size(0, 0
                          ),
                          drawDivider: false,
                          child: InkWell(
                              onTap: () async {
                                bool result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookingDetailScreen(getBookingData!.data!.labourRequests![index]),
                                ));
                                if(result == true){
                                  setState(() {
                                    getBookingAPICall();
                                  });
                                }
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 120,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  DateFormat('dd').format(
                                                      DateTime.parse(getBookingData!.data!.labourRequests
                                                      ![index].date.toString())),
                                                  style: TextStyle(
                                                      color: appColorGrey,
                                                      fontSize: 26),
                                                ),
                                                Text(
                                                  DateFormat('MMM').format(
                                                      DateTime.parse(getBookingData!.data!.labourRequests
                                                      ![index].date.toString())),
                                                  style: TextStyle(
                                                      color: appColorGrey,
                                                      fontSize: 20),
                                                ),
                                              ],
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 20,
                                                  bottom: 20,
                                                  left: 10,
                                                  right: 15),
                                              child: DottedLine(
                                                direction: Axis.vertical,
                                                lineLength: double.infinity,
                                                lineThickness: 1.0,
                                                dashLength: 4.0,
                                                dashColor: Colors.grey[600],
                                                dashRadius: 0.0,
                                                dashGapLength: 4.0,
                                                dashGapColor: Colors.transparent,
                                                dashGapRadius: 0.0,
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Booking Id - ${ getBookingData!.data!.labourRequests
                                                    ![index].id.toString()}",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: appColorBlack,
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                  Container(height: 5),
                                                  Text(
                                                    getBookingData!.data!.labourRequests
                                                    ![index].requirement.toString(),
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: appColorBlack,
                                                        fontSize: 16,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                  Container(height: 2),

                                                  Text(
                                                    "${getBookingData!.data!.labourRequests
                                                    ![index].date.toString()}",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12),
                                                  ),
                                                  Container(height: 2),
                                                  Text(
                                                    "${getBookingData!.data!.labourRequests
                                                    ![index].time.toString()}",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12),
                                                  ),

                                                  // model!.booking![index].status == "Completed"
                                                  //     ? Container(
                                                  //  // width: 80,
                                                  //   height: 30,
                                                  //   alignment: Alignment.center,
                                                  //   decoration: BoxDecoration(
                                                  //     borderRadius: BorderRadius.circular(10.0),
                                                  //     color: Colors.green
                                                  //   ),
                                                  //   child: Text(
                                                  //     model!.booking![index].status!,
                                                  //     maxLines: 1,
                                                  //     textAlign: TextAlign.center,
                                                  //     style: TextStyle(
                                                  //         color: Colors.white,
                                                  //         fontSize: 12),
                                                  //   ),
                                                  // )
                                                  //     : model!.booking![index].status == "Cancelled by user" ? Container(
                                                  //   //width: 80,
                                                  //   height: 30,
                                                  //   alignment: Alignment.center,
                                                  //   decoration: BoxDecoration(
                                                  //       borderRadius: BorderRadius.circular(10.0),
                                                  //       color: Colors.red
                                                  //   ),
                                                  //   child: Text(
                                                  //     model!.booking![index].status!,
                                                  //     maxLines: 1,
                                                  //     textAlign: TextAlign.center,
                                                  //     style: TextStyle(
                                                  //         color: Colors.white,
                                                  //         fontSize: 12),
                                                  //   ),
                                                  // ) : model!.booking![index].status == "Cancelled by vendor" ?
                                                  // Container(
                                                  //   //width: 80,
                                                  //   height: 30,
                                                  //   alignment: Alignment.center,
                                                  //   decoration: BoxDecoration(
                                                  //       borderRadius: BorderRadius.circular(10.0),
                                                  //       color: Colors.red
                                                  //   ),
                                                  //   child: Text(
                                                  //     model!.booking![index].status!,
                                                  //     maxLines: 1,
                                                  //     textAlign: TextAlign.center,
                                                  //     style: TextStyle(
                                                  //         color: appColorWhite,
                                                  //         fontSize: 12),
                                                  //   ),
                                                  // ) :
                                                  // Container(
                                                  // //  width: 80,
                                                  //   height: 30,
                                                  //   alignment: Alignment.center,
                                                  //   decoration: BoxDecoration(
                                                  //       borderRadius: BorderRadius.circular(10.0),
                                                  //       color: backgroundblack
                                                  //   ),
                                                  //   child: Text(
                                                  //     model!.booking![index].status!,
                                                  //     maxLines: 1,
                                                  //     textAlign: TextAlign.center,
                                                  //     style: TextStyle(
                                                  //         color: appColorWhite,
                                                  //         fontSize: 12),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Icon(Icons.arrow_forward_ios_outlined,color: backgroundblack,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ))
                      ));
                },
              )
            : Center(
                child: Text(
                  "Don't have any Orders",
                  style: TextStyle(
                    color: appColorBlack,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              );
  }

  Widget deliveryWidget() {
    return getBookingData == null
        ? Center(
            child:  Container(
                                height: 30,
                                  width: 30,
                                child: CircularProgressIndicator(
                                  color: backgroundblack,
                                ),
                              )
          )
        : getBookingData!.data!.deliveryRequests!.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.only(bottom: 10, top: 10),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                //physics: const NeverScrollableScrollPhysics(),
                itemCount: getBookingData!.data!.deliveryRequests!.length,
                //scrollDirection: Axis.horizontal,
                itemBuilder: (context, int index,) {
                  var dateFormate =  DateFormat("dd/MM/yyyy").format(DateTime.parse(
                      getBookingData!.data!.deliveryRequests
                  ![index].date.toString() ?? ""));
                  return TicketView(
                    drawShadow: true,
                    backgroundColor: appColorWhite,
                    drawArc: true,
                    triangleAxis: Axis.horizontal,
                    borderRadius: 6,
                    triangleSize: Size(0, 0
                    ),
                    drawDivider: false,
                    child: InkWell(
                        onTap: () async {
                          bool result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DeliveryBookingDetails(getBookingData!.data!.deliveryRequests![index]),
                          ));
                          if(result == true){
                            setState(() {
                              getBookingAPICall();
                            });
                          }
                        },
                        child: Container(
                          child: Column(
                            children: [
                             
                              Container(
                                height: 130,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            DateFormat('dd').format(
                                                DateTime.parse(getBookingData!.data!.deliveryRequests
                                                ![index].date.toString())),
                                            style: TextStyle(
                                                color: appColorGrey,
                                                fontSize: 26),
                                          ),
                                          Text(
                                            DateFormat('MMM').format(
                                                DateTime.parse(getBookingData!.data!.deliveryRequests
                                                ![index].date.toString())),
                                            style: TextStyle(
                                                color: appColorGrey,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 20,
                                            bottom: 20,
                                            left: 10,
                                            right: 5),
                                        child: DottedLine(
                                          direction: Axis.vertical,
                                          lineLength: double.infinity,
                                          lineThickness: 1.0,
                                          dashLength: 4.0,
                                          dashColor: Colors.grey[600],
                                          dashRadius: 0.0,
                                          dashGapLength: 4.0,
                                          dashGapColor: Colors.transparent,
                                          dashGapRadius: 0.0,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 7,
                                            width: 7,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              shape: BoxShape.circle
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                            child: VerticalDivider(
                                              color: appColorBlack,
                                            ),
                                          ),
                                          Container(
                                            height: 7,
                                            width: 7,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Booking Id - ${ getBookingData!.data!.deliveryRequests
                                              ![index].id.toString()}",
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: appColorBlack,
                                                  fontSize: 18,
                                                  fontWeight:
                                                  FontWeight.normal),
                                            ),
                                            Container(height: 5),
                                            Text(
                                              getBookingData!.data!.deliveryRequests
                                              ![index].pickupLocation.toString(),
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: appColorBlack,
                                                  fontSize: 10,
                                                  fontWeight:
                                                  FontWeight.normal),
                                            ),
                                            Container(height: 2),
                                            Text(
                                              getBookingData!.data!.deliveryRequests
                                              ![index].dropLocation.toString(),
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: appColorBlack,
                                                  fontSize: 10),
                                            ),

                                            Text(
                                              "${getBookingData!.data!.deliveryRequests
                                              ![index].date.toString()}",
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),

                                            Text(
                                              "${getBookingData!.data!.deliveryRequests
                                              ![index].time.toString()}",
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            ),

                                            // model!.booking![index].status == "Completed"
                                            //     ? Container(
                                            //  // width: 80,
                                            //   height: 30,
                                            //   alignment: Alignment.center,
                                            //   decoration: BoxDecoration(
                                            //     borderRadius: BorderRadius.circular(10.0),
                                            //     color: Colors.green
                                            //   ),
                                            //   child: Text(
                                            //     model!.booking![index].status!,
                                            //     maxLines: 1,
                                            //     textAlign: TextAlign.center,
                                            //     style: TextStyle(
                                            //         color: Colors.white,
                                            //         fontSize: 12),
                                            //   ),
                                            // )
                                            //     : model!.booking![index].status == "Cancelled by user" ? Container(
                                            //   //width: 80,
                                            //   height: 30,
                                            //   alignment: Alignment.center,
                                            //   decoration: BoxDecoration(
                                            //       borderRadius: BorderRadius.circular(10.0),
                                            //       color: Colors.red
                                            //   ),
                                            //   child: Text(
                                            //     model!.booking![index].status!,
                                            //     maxLines: 1,
                                            //     textAlign: TextAlign.center,
                                            //     style: TextStyle(
                                            //         color: Colors.white,
                                            //         fontSize: 12),
                                            //   ),
                                            // ) : model!.booking![index].status == "Cancelled by vendor" ?
                                            // Container(
                                            //   //width: 80,
                                            //   height: 30,
                                            //   alignment: Alignment.center,
                                            //   decoration: BoxDecoration(
                                            //       borderRadius: BorderRadius.circular(10.0),
                                            //       color: Colors.red
                                            //   ),
                                            //   child: Text(
                                            //     model!.booking![index].status!,
                                            //     maxLines: 1,
                                            //     textAlign: TextAlign.center,
                                            //     style: TextStyle(
                                            //         color: appColorWhite,
                                            //         fontSize: 12),
                                            //   ),
                                            // ) :
                                            // Container(
                                            // //  width: 80,
                                            //   height: 30,
                                            //   alignment: Alignment.center,
                                            //   decoration: BoxDecoration(
                                            //       borderRadius: BorderRadius.circular(10.0),
                                            //       color: backgroundblack
                                            //   ),
                                            //   child: Text(
                                            //     model!.booking![index].status!,
                                            //     maxLines: 1,
                                            //     textAlign: TextAlign.center,
                                            //     style: TextStyle(
                                            //         color: appColorWhite,
                                            //         fontSize: 12),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Icon(Icons.arrow_forward_ios_outlined,color: backgroundblack,),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ))
                  );
                },
              )
            : Center(
                child: Text(
                  "Don't have any Booking",
                  style: TextStyle(
                    color: appColorBlack,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              );
  }
}
