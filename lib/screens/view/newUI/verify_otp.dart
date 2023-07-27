import 'dart:convert';

import 'package:ez/block/signup_bloc.dart';
import 'package:ez/screens/view/models/verifyOtpModel.dart';
import 'package:ez/screens/view/newUI/login.dart';
import 'package:ez/screens/view/newUI/signup.dart';
import 'package:ez/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../block/login_bloc.dart';
import '../../../constant/global.dart';
import '../../../share_preference/preferencesKey.dart';
import '../models/LoginWithOtpModel.dart';
import 'newTabbar.dart';

class VerifyOtp extends StatefulWidget {
  final otp, email,userName, mobile;
   final bool signUp;
   VerifyOtp({Key? key, this.otp, this.email, this.userName, this.mobile, required this.signUp}) : super(key: key);

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  var apiOtp;
  var inputOtp;
  ProgressDialog? pr;

  @override
  void initState() {
    apiOtp = widget.otp.toString();
    super.initState();
  }

  String? resendOtp;
  Future<LoginWithOtpModel?> loginWithOtp() async {
    var request = http.MultipartRequest('POST', Uri.parse('$sendOtpUrl'));
    request.fields.addAll({
      'mobile': '${widget.mobile.toString()}',
      'device_token': ''
    });

    http.StreamedResponse response = await request.send();

    print(request);
    print(request.fields);
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      var results = LoginWithOtpModel.fromJson(json.decode(str));
      print("checking result here ${results.message}");
      String? msg;
      msg = results.message;
      Fluttertoast.showToast(msg:"${results.message}");
      return LoginWithOtpModel.fromJson(json.decode(str));
    }
    else {
      return null;
    }
  }


  // Future<LoginWithOtpModel?> loginWithOtp() async {
  //   closeKeyboard();
  //
  //   pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
  //   pr?.style(message: 'Showing some progress...');
  //   pr?.style(
  //     message: 'Please wait...',
  //     borderRadius: 10.0,
  //     backgroundColor: Colors.white,
  //     progressWidget: Container(
  //       height: 10,
  //       width: 10,
  //       margin: EdgeInsets.all(5),
  //       child: CircularProgressIndicator(
  //         strokeWidth: 2.0,
  //         valueColor: AlwaysStoppedAnimation(Colors.blue),
  //       ),
  //     ),
  //     elevation: 10.0,
  //     insetAnimCurve: Curves.easeInOut,
  //     progressTextStyle: TextStyle(
  //         color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
  //     messageTextStyle: TextStyle(
  //         color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
  //   );
  //   var request = http.MultipartRequest('POST', Uri.parse('$registerUrl'));
  //   request.fields.addAll({
  //     'name':'${widget.userName}',
  //     'email':'${widget.email}',
  //     'mobile': '${widget.mobile}',
  //     'device_token': ''
  //   });
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   print(request);
  //   print(request.fields);
  //   pr!.show();
  //   if (response.statusCode == 200) {
  //
  //     final str = await response.stream.bytesToString();
  //     var results = LoginWithOtpModel.fromJson(json.decode(str));
  //     print("checking result here ${results.message} and ${results.otp}");
  //
  //   setState(() {
  //     resendOtp = results.otp.toString();
  //   });
  //     pr!.hide();
  //
  //     // return LoginWithOtpModel.fromJson(json.decode(str));
  //   }
  //   else {
  //     pr!.hide();
  //     print("checking fail response ${response.statusCode}");
  //
  //   }
  // }
  void _signup(BuildContext context) {
    closeKeyboard();

    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr?.style(message: 'Showing some progress...');
    pr?.style(
      message: 'Please wait...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: Container(
        height: 10,
        width: 10,
        margin: EdgeInsets.all(5),
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation(Colors.blue),
        ),
      ),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    // print("checking input ${_unameController.text} and ${_passwordController.text} and ${_emailController.text} and ${_mobileController.text}");
    if (widget.userName.toString().isNotEmpty &&
        widget.mobile.toString().isNotEmpty) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern.toString());
      if (regex.hasMatch(widget.email.toString())) {
        pr?.show();
        // Loader().showIndicator(context);

        signupBloc
            .signupSink(
          widget.email.toString(),
          widget.otp.toString(),
          widget.userName.toString(),
          widget.mobile.toString(),
        )
            .then(
              (userResponse) {
            print("checking data here ${userResponse.responseCode} ");
            if (userResponse.responseCode == Strings.responseSuccess) {
              // String userResponseStr = json.encode(userResponse);
              // preferences.setString(
              //     SharedPreferencesKey.LOGGED_IN_USERRDATA,
              //     userResponseStr);
              pr?.hide();
              Fluttertoast.showToast(msg: "USER REGISTER SUCCESSFULLY");
              signupBloc.dispose();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );

            } else if (userResponse.responseCode == '0') {
              pr?.hide();
              loginerrorDialog(context, "Email id already registered");
            } else {
              pr?.hide();
              loginerrorDialog(
                  context, "Make sure you have entered right credentials");
            }
          },
        );
      } else {
        loginerrorDialog(
            context, "Make sure you have entered right credential");
      }
    } else {
      loginerrorDialog(context, "Please enter valid credential to sign up");
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   backgroundColor: appColorWhite,
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      //   title: Text("Verification",style: TextStyle(color: backgroundblack),),
      //   leading: InkWell(
      //     onTap: (){
      //       Navigator.of(context).pop();
      //     },
      //     child: Container(
      //       child: Icon(Icons.arrow_back_ios,color: backgroundblack,),
      //     ),
      //   ),
      // ),
      backgroundColor: backgroundblack,
      body: SafeArea(
        child:  Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12, top: 0, bottom: 0 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0.0, ),
                child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios,color: appColorWhite,)),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height-70,
                decoration: BoxDecoration(
                  color: appColorWhite,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30),),
                ),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.s,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text("Verification",
                        style: TextStyle(
                          color: backgroundblack,
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                        ),),
                    ),
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                    //       child: CircleAvatar(
                    //         backgroundColor: Colors.white,
                    //         child: IconButton(
                    //           onPressed: () {
                    //             Navigator.pop(context);
                    //           },
                    //           icon: Icon(Icons.arrow_back_outlined),
                    //           color: Colors.black,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),

                    // CircleAvatar(
                    //   backgroundColor: Colors.white,
                    //   radius: 60,
                    //   child: Image(
                    //     image: AssetImage("assets/images/ez_logo.png"),
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.02,
                    // ),
                    Text(
                      "Enter Your 4 Digit Code" + "\n ${resendOtp == null ? apiOtp : resendOtp}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: backgroundblack,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    // SizedBox(
                    //   height: height * 0.02,
                    // ),
                    Text(
                      "Don't share it with any other",
                      style: TextStyle(
                          color: Color(0xff767676),
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    SizedBox(
                      width: width * 0.8,
                      child: OTPTextField(
                        length: 4,
                        width: MediaQuery.of(context).size.width,
                        fieldWidth: 60,
                        style: TextStyle(fontSize: 17),
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldStyle: FieldStyle.box,
                        onCompleted: (pin) {
                          setState(() {
                            inputOtp = pin;
                          });
                          print("Completed: " + pin);
                        },
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    // Text(
                    //   "Enter 4 Digit OTP number Sent to your Email",
                    //   style: TextStyle(
                    //       color: Color(0xff767676),
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 14),
                    // ),

                    // SizedBox(
                    //   height: height * 0.04,
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: backgroundblack,
                          onPrimary: Colors.white,
                          shadowColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          minimumSize: Size(310, 45), //////// HERE
                        ),
                        onPressed: () {
                          if(widget.otp == inputOtp && inputOtp.length == 4) {
                            if(widget.signUp){
                          _signup(context);
                            }
                            else {
                              varifyOTP();
                            }
                          }
                          else{
                            Fluttertoast.showToast(msg: "Enter valid otp");
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 16),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 60.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                          "Didn't received verification code? ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                          TextButton(
                            onPressed: ()  {
                              loginWithOtp();
                            },
                            child: Text(
                              "Resend",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                  color: backgroundblack,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                          ),],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
        // Stack(
        //   children: [
        //     // CustomScrollView(
        //     //   scrollDirection: Axis.vertical,
        //     //   shrinkWrap: true,
        //     // ),
        //     /*Container(
        //       height: double.infinity,
        //       width: double.infinity,
        //       child: Column(
        //         children: [
        //           Container(
        //             height: height * 0.3,
        //             child: Image.asset(
        //               "assets/images/loginappbar.png",
        //               fit: BoxFit.fill,
        //             ),
        //           )
        //         ],
        //       ),
        //     ),*/
        //     ListView(
        //       shrinkWrap: true,
        //       physics: ClampingScrollPhysics(),
        //       children: [
        //         Column(
        //           children: [
        //             Row(
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
        //                   child: CircleAvatar(
        //                     backgroundColor: Colors.white,
        //                     child: IconButton(
        //                       onPressed: () {
        //                         Navigator.pop(context);
        //                       },
        //                       icon: Icon(Icons.arrow_back_outlined),
        //                       color: Colors.black,
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //
        //             CircleAvatar(
        //               backgroundColor: Colors.white,
        //               radius: 60,
        //               child: Image(
        //                 image: AssetImage("assets/images/ez_logo.png"),
        //                 fit: BoxFit.fill,
        //               ),
        //             ),
        //             SizedBox(
        //               height: MediaQuery.of(context).size.height * 0.02,
        //             ),
        //             Text(
        //               "ENTER YOUR 4 DIGIT CODE" + "\nOTP ${resendOtp == null ? apiOtp : resendOtp}",
        //               textAlign: TextAlign.center,
        //               style: TextStyle(
        //                   color: Colors.black,
        //                   fontWeight: FontWeight.w600,
        //                   fontSize: 20),
        //             ),
        //             SizedBox(
        //               height: height * 0.02,
        //             ),
        //             Text(
        //               "Don't share it with any other",
        //               style: TextStyle(
        //                   color: Color(0xff767676),
        //                   fontWeight: FontWeight.w500,
        //                   fontSize: 14),
        //             ),
        //             SizedBox(
        //               height: height * 0.04,
        //             ),
        //             SizedBox(
        //               width: width * 0.8,
        //               child: OTPTextField(
        //                 length: 4,
        //                 width: MediaQuery.of(context).size.width,
        //                 fieldWidth: 60,
        //                 style: TextStyle(fontSize: 17),
        //                 textFieldAlignment: MainAxisAlignment.spaceAround,
        //                 fieldStyle: FieldStyle.box,
        //                 onCompleted: (pin) {
        //                   setState(() {
        //                     inputOtp = pin;
        //                   });
        //                   print("Completed: " + pin);
        //                 },
        //               ),
        //             ),
        //             SizedBox(
        //               height: height * 0.01,
        //             ),
        //             Text(
        //               "Enter 4 Digit OTP number Sent to your Email",
        //               style: TextStyle(
        //                   color: Color(0xff767676),
        //                   fontWeight: FontWeight.w500,
        //                   fontSize: 14),
        //             ),
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   "Didn't Got Code? ",
        //                   style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w600,
        //                       fontSize: 14),
        //                 ),
        //                 TextButton(
        //                   onPressed: (){
        //                     loginWithOtp();
        //                   },
        //                   child: Text(
        //                     "Resend",
        //                     style: TextStyle(
        //                         color: Color(0xffF4B71E),
        //                         fontWeight: FontWeight.w600,
        //                         fontSize: 15),
        //                   ),
        //                 )
        //               ],
        //             ),
        //             SizedBox(
        //               height: height * 0.04,
        //             ),
        //             ElevatedButton(
        //               style: ElevatedButton.styleFrom(
        //                 primary: backgroundblack,
        //                 onPrimary: Colors.white,
        //                 shadowColor: Colors.white,
        //                 elevation: 3,
        //                 shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(8.0)),
        //                 minimumSize: Size(310, 50), //////// HERE
        //               ),
        //               onPressed: () => varifyOTP(),
        //               child: Text(
        //                 'Submit',
        //                 style: TextStyle(
        //                     fontWeight: FontWeight.w300, fontSize: 20),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ],
        //     )
        //   ],
        // ),
      ),
    );
  }

  Future varifyOTP() async {
    closeKeyboard();

    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr?.style(message: 'Showing some progress...');
    pr?.style(
      message: 'Please wait...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: Container(
        height: 10,
        width: 10,
        margin: EdgeInsets.all(5),
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation(Colors.blue),
        ),
      ),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

    var request = http.MultipartRequest('POST', Uri.parse('$verifyOtpUrl'));
    request.fields.addAll({
      'mobile': '${widget.email}',
      'otp': '$inputOtp'
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      final jsonResponse = VerifyOtpModel.fromJson(json.decode(str));
      if(jsonResponse.responseCode == "1"){
        String userResponseStr = json.encode(jsonResponse);
        SharedPreferences preferences =
        await SharedPreferences.getInstance();
        preferences.setString(
            SharedPreferencesKey.LOGGED_IN_USERRDATA, userResponseStr);
        // Loader().hideIndicator(context);
        loginBloc.dispose();
        // pr!.hide();
        // if(widget.signUp == true){
        //   Fluttertoast.showToast(msg: "Otp Verified Successfully");
        //   Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(
        //       builder: (context) => SignUp(),
        //     ),
        //         (Route<dynamic> route) => false,
        //   );
        // }else{
          Fluttertoast.showToast(msg: "User Login Successfully");
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => TabbarScreen(),
            ),
                (Route<dynamic> route) => false,
          );
        // }
      }
      return VerifyOtpModel.fromJson(json.decode(str));
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
