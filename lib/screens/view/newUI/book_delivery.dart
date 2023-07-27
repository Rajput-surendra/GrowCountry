import 'package:ez/screens/view/models/calculate_delcharge.dart';
import 'package:flutter/material.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';

import 'dart:convert';

import 'package:ez/screens/view/models/ServiceRequestModel.dart';
import 'package:ez/screens/view/models/address_model.dart';
import 'package:ez/screens/view/newUI/manage_address.dart';
import 'package:ez/screens/view/newUI/newTabbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../constant/global.dart';
import '../../../strings/strings.dart';
import '../models/categories_model.dart';

class BookDeliveryService extends StatefulWidget {
  const BookDeliveryService({Key? key}) : super(key: key);

  @override
  State<BookDeliveryService> createState() => _BookDeliveryServiceState();
}

class _BookDeliveryServiceState extends State<BookDeliveryService> {
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController pickLocationController = TextEditingController();
  TextEditingController dropLocationController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String? selectedCategory;
  String? selectedSubcategory;
  String? selectedCatName;
  String? selectedSubCatName;
  AllCateModel? collectionModal;

  List<Categories> catlist = [];
  _getCollection() async {
    var uri = Uri.parse('$getCategoryUrl');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    // print(baseUrl.toString());

    request.headers.addAll(headers);
    request.fields['type_id'] = "1";
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if (mounted) {
      setState(() {
        collectionModal = AllCateModel.fromJson(userData);
        catlist = AllCateModel.fromJson(userData).categories!;
        print(
            "ooooo ${collectionModal!.status} and ${collectionModal!.categories!.length} and ${userID}");
      });
    }
    print(responseData);
  }

  List<Categories> subCatList = [];

  getSubCategory() async {
    var uri = Uri.parse('$getCategoryUrl');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    print("checking id here ${selectedCategory}");
    // print(baseUrl.toString());
    request.headers.addAll(headers);
    request.fields['category_id'] = selectedCategory.toString();
    request.fields['type_id'] = "1";
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if (mounted) {
      setState(() {
        subCatList = AllCateModel.fromJson(userData).categories!;
        collectionModal = AllCateModel.fromJson(userData);
      });
    }
    print(responseData);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCollection();
  }

  List<String> list = <String>['kg', 'gms'];
  String dropdownValue = "kg";
  String _dateValue = '';
  String addId = '';
  var dateFormate;
  String _pickedLocation = '';
  String? pickLat;
  String? pickLong;
  String? dropLat;
  String? dropLong;

  Future getAddress(id) async {
    var request = http.MultipartRequest('POST', Uri.parse('$getAddressUrl'));
    request.fields.addAll({'id': '$id', 'user_id': '$userID'});

    print(request);
    print(request.fields);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      final jsonResponse = AddressModel.fromJson(json.decode(str));
      if (jsonResponse.responseCode == "1") {
        setState(() {
          _pickedLocation =
              "${jsonResponse.data![0].address!}, ${jsonResponse.data![0].building}";
        });
      }
      print(_pickedLocation);
      return AddressModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        // insetPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        title: const Center(
          child: Text(
            "Summary",
            style: TextStyle(
                color: backgroundblack,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ),
        content: SingleChildScrollView(
            child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              rowElements(
                "Pickup Location",
                '${pickLocationController.text.toString()}',
              ),
              rowElements(
                "Drop Location",
                '${dropLocationController.text.toString()}',
              ),
              rowElements(
                "Select Vehicle",
                '${selectVehicle.toString()}',
              ),
              rowElements(
                "Date",
                '${dateFormate.toString()}',
              ),
              rowElements(
                "Time",
                "${selectedTime!.format(context)}",
              ),
              rowElements(
                "Select Category",
                '${selectedCategory.toString()}',
              ),
              rowElements(
                "Select Subcategory",
                '${selectedSubcategory.toString()}',
              ),
              rowElements("Dimension",
                  "Height: ${heightController.text.toString()}  Width: ${widthController.text.toString()}"),
              rowElements("Weight", '${weightController.text.toString()}'),
              rowElements(
                  "Delivery Charges", '${delCharge.toStringAsFixed(2)}'),
              rowElements("Tax Amount", '${gstAmount.toStringAsFixed(2)}'),
              rowElements("Total", '${total.toStringAsFixed(2)}'),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: backgroundblack,
                    ),
                    onPressed: () {
                      submitRequest();
                    },
                  ),
                ),
              )
            ],
          ),
        )),
        actions: <Widget>[],
      ),
    );

    if (_formKey.currentState!.validate()) {
    } else {}
  }

  final _formKey = GlobalKey<FormState>();

  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        //firstDate: DateTime.now().subtract(Duration(days: 1)),
        // lastDate: new DateTime(2022),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: Colors.black, //Head background
                accentColor: Colors.black,
                colorScheme:
                    ColorScheme.light(primary: const Color(0xFFEB6C67)),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);
        print(_dateValue);
        dateFormate =
            DateFormat("dd/MM/yyyy").format(DateTime.parse(_dateValue ?? ""));
        sDate =
            DateFormat("yyyy-MM-dd").format(DateTime.parse(_dateValue ?? ""));
        dateController.text = dateFormate;
      });
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  TimeOfDay? selectedTime;
  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        useRootNavigator: true,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(primary: backgroundblack),
                buttonTheme: ButtonThemeData(
                    colorScheme: ColorScheme.light(primary: backgroundblack))),
            child: MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: false),
                child: child!),
          );
        });
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay.replacing(hour: timeOfDay.hourOfPeriod);
        timeController.text = selectedTime!.format(context);
      });
    }
    var per = selectedTime!.period.toString().split(".");
    print(
        "selected time here ${selectedTime!.format(context).toString()} and ${per[1]}");
  }

  String? sDate;
  double delCharge = 0;
  double gstAmount = 0;
  double gst = 18;
  double total = 0;

  calculateDeliveryCharges() async {
    var headers = {'Cookie': 'ci_session=cf2fmpq7vue0kthvj5s046uv4m2j5r11'};
    var request =
        http.MultipartRequest('POST', Uri.parse('$calculateDelChargeUrl'));
    request.fields.addAll({
      // 'pickup_location': '${pickLocationController.text.toString()}',
      // 'drop_location': '${dropLocationController.text.toString()}',
      // 'vehicle_type': '${selectVehicle.toString()}',
      // 'date': '${sDate.toString()}',
      // 'time': "${selectedTime!.format(context)}",
      // 'height': '${heightController.text.toString()}',
      // 'length': '${widthController.text.toString()}',
      // 'weight': '${weightController.text.toString()}',
      'pick_lat': '${pickLat.toString()}',
      'pick_lng': '${pickLong.toString()}',
      'drop_lat': '${dropLat.toString()}',
      'drop_lng': '${dropLong.toString()}',
      // 'user_id': '${userID}',
      // 'category_id': '${selectedCategory.toString()}',
      // 'sub_category_id': '${selectedSubcategory.toString()}',
      // 'budget': '${priceController.text}'
    });

    print("ok @@ ${request.fields}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse =
          CalculateDelcharge.fromJson(json.decode(finalResult));
      print(
          "checking json response ${jsonResponse.message} and ${jsonResponse.responseCode}");
      if (jsonResponse.responseCode == "0" ||
          jsonResponse.responseCode == null) {
        Fluttertoast.showToast(msg: "${jsonResponse.message}");
        // Navigator.pop(context);
      } else {
        delCharge = double.parse(jsonResponse.charge.toString());
        gstAmount = delCharge * gst / 100;
        total = delCharge + gstAmount;
        print("this is @@ $delCharge and $gstAmount && $total");

        // /Fluttertoast.showToast(msg: "${jsonResponse.message}");
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => TabbarScreen()));
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  submitRequest() async {
    var headers = {'Cookie': 'ci_session=cf2fmpq7vue0kthvj5s046uv4m2j5r11'};
    var request = http.MultipartRequest('POST', Uri.parse('$bookDeliveryUrl'));
    request.fields.addAll({
      'pickup_location': '${pickLocationController.text.toString()}',
      'drop_location': '${dropLocationController.text.toString()}',
      'vehicle_type': '${selectVehicle.toString()}',
      'date': '${sDate.toString()}',
      'time': "${selectedTime!.format(context)}",
      'height': '${heightController.text.toString()}',
      'length': '${widthController.text.toString()}',
      'weight': '${weightController.text.toString()}',
      'unit' : '${dropdownValue.toString()}',
      'pickup_lat': '${pickLat.toString()}',
      'pickup_lng': '${pickLong.toString()}',
      'drop_lat': '${dropLat.toString()}',
      'drop_lng': '${dropLong.toString()}',
      'user_id': '${userID.toString()}',
      'category_id': '${selectedCategory.toString()}',
      'sub_category_id': '${selectedSubcategory.toString()}',
      'sub_total': '${delCharge.toStringAsFixed(2)}',
      'delivery_charge': '${delCharge.toStringAsFixed(2)}',
      'tax_amount': '${gstAmount.toStringAsFixed(2)}',
      'total': '${total.toStringAsFixed(2)}'
      // 'budget': '${priceController.text}'
    });

    print("ok @@ ${request.fields}");
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse =
          ServiceRequestModel.fromJson(json.decode(finalResult));
      print(
          "checking json response ${jsonResponse.message} and ${jsonResponse.responseCode}");
      if (jsonResponse.responseCode == "0" ||
          jsonResponse.responseCode == null) {
        Fluttertoast.showToast(msg: "${jsonResponse.message}");
        Navigator.of(context, rootNavigator: true).pop();
      } else {
        Fluttertoast.showToast(msg: "${jsonResponse.message}");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TabbarScreen()));
        Navigator.of(context, rootNavigator: true).pop();
      }
      Navigator.of(context, rootNavigator: true).pop();
    } else {
      print(response.reasonPhrase);
    }
  }

  _getPickLocation() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
              "AIzaSyCqQW9tN814NYD_MdsLIb35HRY65hHomco",
            )));
    print(
        "checking adderss detail ${result.country!.name.toString()} and ${result.locality.toString()} and ${result.country!.shortName.toString()} ");
    setState(() {
      pickLocationController.text = result.formattedAddress.toString();
      pickLat = result.latLng!.latitude.toString();
      pickLong = result.latLng!.longitude.toString();
      // cityC.text = result.locality.toString();
      // stateC.text = result.administrativeAreaLevel1!.name.toString();
      // countryC.text = result.country!.name.toString();
      // lat = result.latLng!.latitude;
      // long = result.latLng!.longitude;
      // pincodeC.text = result.postalCode.toString();
    });
    print("this is picked LAT LONG $pickLat @@ $pickLong");
  }

  _getDropLocation() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
              "AIzaSyCqQW9tN814NYD_MdsLIb35HRY65hHomco",
            )));
    print(
        "checking adderss detail ${result.country!.name.toString()} and ${result.locality.toString()} and ${result.country!.shortName.toString()} ** ${result.latLng}");
    setState(() {
      dropLocationController.text = result.formattedAddress.toString();
      dropLat = result.latLng!.latitude.toString();
      dropLong = result.latLng!.longitude.toString();
    });
    print("this is picked LAT LONG $dropLat @@ $dropLong");
  }

  var items = [
    'Select Vehicle',
    '2-Wheeler',
    '3-Wheeler',
    '4-Wheeler',
  ];
  String selectVehicle = "Select Vehicle";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundblack,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundblack,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: appColorWhite,
          ),
        ),
        title: Text(
          "Delivery Service",
          style: TextStyle(color: appColorWhite),
        ),
      ),
      body: Container(
          padding: EdgeInsets.only(top: 30),
          // height: MediaQuery.of(context).size.height-120,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: appColorWhite,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              )),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Pickup location",
                    style: TextStyle(fontSize: 15, color: appColorGrey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                  child: TextFormField(
                    controller: pickLocationController,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Enter Pickup Location";
                      }
                    },
                    onTap: () {
                      _getPickLocation();
                    },
                    decoration: InputDecoration(
                        hintText: "Pickup Location",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(
                                color: appColorBlack.withOpacity(0.5)))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Drop location",
                    style: TextStyle(fontSize: 15, color: appColorGrey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                  child: TextFormField(
                    controller: dropLocationController,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Enter Drop Location";
                      }
                    },
                    onTap: () {
                      _getDropLocation();
                    },
                    decoration: InputDecoration(
                        hintText: "Drop Location",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(
                                color: appColorBlack.withOpacity(0.5)))),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Select Vehicle",
                    style: TextStyle(fontSize: 15, color: appColorGrey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    // alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border:
                            Border.all(color: appColorBlack.withOpacity(0.5))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 280,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              iconEnabledColor: appColorWhite,
                              iconDisabledColor: appColorWhite,

                              // Initial Value
                              value: selectVehicle,

                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectVehicle = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down)
                      ],
                    ),

                    //_pickedLocation.length > 0 ? Text("${_pickedLocation}",style: TextStyle(height: 1.2),) : Text("Select address",style: TextStyle(color: appColorBlack.withOpacity(0.5)),)
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Date",
                    style: TextStyle(fontSize: 15, color: appColorGrey),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                  child: InkWell(
                      onTap: () {
                        _selectDate();
                      },
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                                color: appColorBlack.withOpacity(0.5))),
                        child: _dateValue.length > 0
                            ? Text(
                                "${dateFormate}",
                                style: TextStyle(
                                    color: appColorBlack, fontSize: 15),
                              )
                            : Text(
                                "Select Date",
                                style: TextStyle(
                                    color: appColorBlack.withOpacity(0.5),
                                    fontSize: 15),
                              ),
                      )
                      // TextFormField( controller: dateController,
                      //   validator: (v){
                      //     if(v!.isEmpty){
                      //       return "Enter date";
                      //     }
                      //   },
                      //   readOnly: true,
                      //   decoration: InputDecoration(
                      //       hintText: "Select Date",
                      //       border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(7),
                      //           borderSide: BorderSide(color: appColorBlack.withOpacity(0.5))
                      //       )
                      //   ),),
                      ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Time",
                    style: TextStyle(fontSize: 15, color: appColorGrey),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                  child: InkWell(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: Container(
                          height: 60,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  color: appColorBlack.withOpacity(0.5))),
                          child: selectedTime != null
                              ? Text("${selectedTime!.format(context)}")
                              : Text(
                                  "Select time",
                                  style: TextStyle(
                                      color: appColorBlack.withOpacity(0.5),
                                      fontSize: 15),
                                ))
                      // TextFormField( controller: locationController,
                      //   validator: (v){
                      //     if(v!.isEmpty){
                      //       return "Enter time";
                      //     }
                      //   },
                      //   readOnly: true,
                      //   decoration: InputDecoration(
                      //       hintText: "Select time",
                      //       border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(7),
                      //           borderSide: BorderSide(color: appColorBlack.withOpacity(0.5))
                      //       )
                      //   ),),
                      ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Select Category",
                    style: TextStyle(fontSize: 15, color: appColorGrey),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border:
                            Border.all(color: appColorBlack.withOpacity(0.3))),
                    child: DropdownButton(
                      // Initial Value
                      value: selectedCategory,
                      underline: Container(),
                      isExpanded: true,
                      // Down Arrow Icon
                      icon: Icon(Icons.keyboard_arrow_down),
                      hint: Text("Select category"),
                      // Array list of items
                      items: catlist.map((items) {
                        return DropdownMenuItem(
                          value: items.id,
                          child: Container(child: Text(items.cName.toString())),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategory = newValue!;
                          getSubCategory();
                          print("selected category ${selectedCategory}");
                        });
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Select SubCategory",
                    style: TextStyle(fontSize: 15, color: appColorGrey),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border:
                            Border.all(color: appColorBlack.withOpacity(0.3))),
                    child: DropdownButton(
                      // Initial Value
                      value: selectedSubcategory,
                      underline: Container(),
                      // Down Arrow Icon
                      icon: Container(
                          // width: MediaQuery.of(context).size.width/1.5,
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.keyboard_arrow_down)),
                      hint: Container(
                          width: MediaQuery.of(context).size.width / 1.25,
                          child: Text("Select sub category")),
                      // Array list of items
                      items: subCatList.map((items) {
                        return DropdownMenuItem(
                          value: items.id,
                          child: Container(child: Text(items.cName.toString())),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSubcategory = newValue!;
                          print("selected sub category ${selectedSubcategory}");
                        });
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Dimension",
                    style: TextStyle(fontSize: 15, color: appColorGrey),
                  ),
                ),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        child: TextFormField(
                          controller: heightController,
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Enter height";
                            }
                          },
                          decoration: InputDecoration(
                              suffix: Text(
                                "Cm",
                                style: TextStyle(fontSize: 14),
                              ),
                              hintText: "Height",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(
                                      color: appColorBlack.withOpacity(0.5)))),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5.0, bottom: 10, left: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        child: TextFormField(
                          controller: widthController,
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Enter width";
                            }
                          },
                          decoration: InputDecoration(
                              suffix: Text(
                                "Cm",
                                style: TextStyle(fontSize: 14),
                              ),
                              hintText: "Width",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(
                                      color: appColorBlack.withOpacity(0.5)))),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Weight",
                    style: TextStyle(fontSize: 15, color: appColorGrey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: TextFormField(
                          controller: weightController,
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Enter Weight";
                            }
                          },
                          decoration: InputDecoration(
                              // suffix: Text(
                              //   "Kg",
                              //   style: TextStyle(fontSize: 14),
                              // ),
                              hintText: "Weight",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                  borderSide: BorderSide(
                                      color: appColorBlack.withOpacity(0.5)))),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey)
                        ),
                        height: 60,
                        width: MediaQuery.of(context).size.width/3,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(

                            value: dropdownValue,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black54),
                            underline: Container(
                              // height: 2,
                              color: Colors.black54,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 10),
                  child: InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        calculateDeliveryCharges();
                        _showDialog();
                        //
                      } else {
                        Fluttertoast.showToast(msg: "Please Enter all fields");
                      }
                    },
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: backgroundblack,
                          borderRadius: BorderRadius.circular(7)),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: appColorWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
