import 'package:ez/models/labour_model.dart';
import 'package:ez/screens/view/newUI/RequestService.dart';
import 'package:ez/screens/view/newUI/book_labour.dart';
import 'package:flutter/material.dart';

import '../../../constant/global.dart';

class LabourDetail extends StatefulWidget {
  Labour? model;

   LabourDetail({Key? key, this.model}) : super(key: key);

  @override
  State<LabourDetail> createState() => _LabourDetailState();
}

class _LabourDetailState extends State<LabourDetail> {
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
        title: Text("Labour Details", style: TextStyle(
            color: appColorWhite
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          padding: EdgeInsets.only(top: 30, left: 15, right: 15),
          // height: MediaQuery.of(context).size.height-120,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: appColorWhite,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30),)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(20),
                  // only(
                  //     topLeft: Radius.circular(10),
                  //     topRight: Radius.circular(10)),
                  image: DecorationImage(
                    image: NetworkImage("${widget.model!.profileImage}",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.model!.uname}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: appColorBlack
                      ),),
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        child: Text("${widget.model!.address}",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: appColorGrey
                          ),),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star,color: Colors.yellow,),
                          Text("4.5",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: appColorBlack
                            ),),
                        ],
                      ),
                      Text("  ₹ ${widget.model!.perDCharge}",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: appColorGrey
                        ),),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20,),
              Text("Description",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: appColorBlack
                ),),
              Text("${widget.model!.description}",
                maxLines: 5,
                // "Lorem ipsum is typically a corrupted version of De "
                //     "finibus bonorum et malorum, a 1st-century BC text by the Roman "
                //     "statesman and philosopher Cicero, with words altered, added, "
                //     "and removed to make it nonsensical and improper Latin.",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: appColorBlack
                ),
              ),
               SizedBox(height: 40,),
               ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(15)
                   ),
                   fixedSize: Size(MediaQuery.of(context).size.width, 50),
                   primary: backgroundblack
                 ),
                   onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> BookLabourService(
                     labourId: "${widget.model!.id}",
                   )));

               }, child: Text("Booking"))

            ],
          )
        ),
      ),
    );
  }
}
