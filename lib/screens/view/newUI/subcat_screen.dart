import 'dart:convert';

import 'package:ez/constant/global.dart';
import 'package:ez/screens/view/models/categories_model.dart';
import 'package:ez/strings/strings.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'AllProviderService.dart';
import 'category_labour.dart';

class SubCategory extends StatefulWidget {
  final title;
  const SubCategory({Key? key, this.title}) : super(key: key);

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {

  List<Map<String, dynamic>> services = [
    {"image": "assets/images/industrial.png", "name": "Industrial Labour"},
    {"image": "assets/images/realstate.png", "name": "Real Estate Worker"},
    {"image": "assets/images/sales.png", "name": "Sales Support Person"},
    {"image": "assets/images/other.png", "name": "Other"},
  ];

  AllCateModel? collectionModal;
  _getCollection() async {
    var uri = Uri.parse('$getCategoryUrl');
    var request = new http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields['type_id'] = "0";
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCollection();

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
          child: collectionModal != null ?
          ListView.builder(
            padding: EdgeInsets.only(
              bottom: 10,
              top: 0,
            ),
            itemCount: collectionModal!.categories!.length ,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, int index,) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0, left: 20, right: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        ServiceWorkers(title: collectionModal!.categories![index].cName.toString(),
                        id: collectionModal!.categories![index].id.toString(),)
                    ));

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           SubCategoryScreen(id: categories.id!, name: categories.cName!,image: categories.img,description: categories.description,)
                    //     // ViewCategory(id: categories.id!, name: categories.cName!)
                    //   ),
                    // );
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 15),
                    width: 200,
                    height: 80,
                    decoration: BoxDecoration(
                        border: Border.all(color: backgroundblack),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    // elevation: 3,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 12),
                              child: Container(
                                // width: 120,
                                height: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.network(
                                    collectionModal!.categories![index].img.toString(),
                                    // services[index]['image'],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 120,
                              child: Text(
                                collectionModal!.categories![index].cName.toString(),
                                style: TextStyle(
                                    color: backgroundblack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios_outlined,
                        color: backgroundblack,)
                      ],
                    ),
                  ),
                ),
              );

              // sortingCard(
              //   context, collectionModal!.categories![index]);
            },
          )
              : Center(
              child: Container(
            height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: backgroundblack,
              )))
        ),
      ),
    );
  }
}
