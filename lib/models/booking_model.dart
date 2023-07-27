/// response_code : "1"
/// message : "Booking requests"
/// status : "success"
/// data : {"labour_requests":[{"cat_name":"Industrial Labour","labour_name":"Pramod","labour_email":"pramodalpha@gmsil.com","labour_mobile":"9111177049","username":"Karan","email":"karanevil.singhtomar@gmail.com","mobile":"8770496665","id":"21","user_id":"118","labour_id":"90","date":"2022-11-16","time":"04:08:00","quantity":"4","sub_total":"0.00","amount":"500.00","tax_amount":"0.00","total":"0.00","payment_status":"0","payment_type":null,"requirement":"Construction","status":"0","comment":null,"created_at":"2022-11-14 10:39:34","updated_at":"2022-11-14 10:39:34"},{"cat_name":"Industrial Labour","labour_name":"Pramod","labour_email":"pramodalpha@gmsil.com","labour_mobile":"9111177049","username":"Karan","email":"karanevil.singhtomar@gmail.com","mobile":"8770496665","id":"22","user_id":"118","labour_id":"90","date":"2022-11-16","time":"04:08:00","quantity":"4","sub_total":"0.00","amount":"500.00","tax_amount":"0.00","total":"0.00","payment_status":"0","payment_type":null,"requirement":" Construction","status":"0","comment":null,"created_at":"2022-11-14 10:42:46","updated_at":"2022-11-14 10:42:46"}],"delivery_requests":[{"id":"1","pickup_location":" 83, Ratna Lok Colony, Indore, Madhya Pradesh 452010, India","drop_location":" 201/A, RamKrishna Bagh, Nyay Nagar NX A B Sector, Indore, Madhya Pradesh 452010, India","vehicle_type":"3","date":"2022-11-16","time":"03:30:00","category_id":"79","sub_category_id":"82","height":" 200","length":" 300","unit":" kg","weight":" 20","pickup_lat":" 22.7484868","pickup_lng":" 75.8977327","drop_lat":" 22.746151526100977","drop_lng":" 75.90965900570154","status":"1","driver_id":"89","user_id":"118","rejected_by":" 89, 89, 89","created_at":"2022-11-14 13:15:32","updated_at":"2022-11-15 07:24:29","delivery_charge":"150","sub_total":"150.00","tax_amount":"27.00","total":"177.00","is_paid":"0","otp":"1234","image":null},{"id":"2","pickup_location":"83, Ratna Lok Colony, Indore, Madhya Pradesh 452010, India","drop_location":"201/A, RamKrishna Bagh, Nyay Nagar NX A B Sector, Indore, Madhya Pradesh 452010, India","vehicle_type":"3","date":"2022-11-16","time":"03:30:00","category_id":"79","sub_category_id":"82","height":"200","length":"300","unit":"kg","weight":"20","pickup_lat":"22.7484868","pickup_lng":"75.8977327","drop_lat":"22.746151526100977","drop_lng":"75.90965900570154","status":"0","driver_id":null,"user_id":"118","rejected_by":" 89, 89, 89","created_at":"2022-11-14 13:15:50","updated_at":"2022-11-15 07:24:34","delivery_charge":"150","sub_total":"150.00","tax_amount":"27.00","total":"177.00","is_paid":"0","otp":"1234","image":null}]}

class BookingModel {
  BookingModel({
      String? responseCode, 
      String? message, 
      String? status, 
      Data? data,}){
    _responseCode = responseCode;
    _message = message;
    _status = status;
    _data = data;
}

  BookingModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _responseCode;
  String? _message;
  String? _status;
  Data? _data;
BookingModel copyWith({  String? responseCode,
  String? message,
  String? status,
  Data? data,
}) => BookingModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  status: status ?? _status,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  String? get status => _status;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// labour_requests : [{"cat_name":"Industrial Labour","labour_name":"Pramod","labour_email":"pramodalpha@gmsil.com","labour_mobile":"9111177049","username":"Karan","email":"karanevil.singhtomar@gmail.com","mobile":"8770496665","id":"21","user_id":"118","labour_id":"90","date":"2022-11-16","time":"04:08:00","quantity":"4","sub_total":"0.00","amount":"500.00","tax_amount":"0.00","total":"0.00","payment_status":"0","payment_type":null,"requirement":"Construction","status":"0","comment":null,"created_at":"2022-11-14 10:39:34","updated_at":"2022-11-14 10:39:34"},{"cat_name":"Industrial Labour","labour_name":"Pramod","labour_email":"pramodalpha@gmsil.com","labour_mobile":"9111177049","username":"Karan","email":"karanevil.singhtomar@gmail.com","mobile":"8770496665","id":"22","user_id":"118","labour_id":"90","date":"2022-11-16","time":"04:08:00","quantity":"4","sub_total":"0.00","amount":"500.00","tax_amount":"0.00","total":"0.00","payment_status":"0","payment_type":null,"requirement":" Construction","status":"0","comment":null,"created_at":"2022-11-14 10:42:46","updated_at":"2022-11-14 10:42:46"}]
/// delivery_requests : [{"id":"1","pickup_location":" 83, Ratna Lok Colony, Indore, Madhya Pradesh 452010, India","drop_location":" 201/A, RamKrishna Bagh, Nyay Nagar NX A B Sector, Indore, Madhya Pradesh 452010, India","vehicle_type":"3","date":"2022-11-16","time":"03:30:00","category_id":"79","sub_category_id":"82","height":" 200","length":" 300","unit":" kg","weight":" 20","pickup_lat":" 22.7484868","pickup_lng":" 75.8977327","drop_lat":" 22.746151526100977","drop_lng":" 75.90965900570154","status":"1","driver_id":"89","user_id":"118","rejected_by":" 89, 89, 89","created_at":"2022-11-14 13:15:32","updated_at":"2022-11-15 07:24:29","delivery_charge":"150","sub_total":"150.00","tax_amount":"27.00","total":"177.00","is_paid":"0","otp":"1234","image":null},{"id":"2","pickup_location":"83, Ratna Lok Colony, Indore, Madhya Pradesh 452010, India","drop_location":"201/A, RamKrishna Bagh, Nyay Nagar NX A B Sector, Indore, Madhya Pradesh 452010, India","vehicle_type":"3","date":"2022-11-16","time":"03:30:00","category_id":"79","sub_category_id":"82","height":"200","length":"300","unit":"kg","weight":"20","pickup_lat":"22.7484868","pickup_lng":"75.8977327","drop_lat":"22.746151526100977","drop_lng":"75.90965900570154","status":"0","driver_id":null,"user_id":"118","rejected_by":" 89, 89, 89","created_at":"2022-11-14 13:15:50","updated_at":"2022-11-15 07:24:34","delivery_charge":"150","sub_total":"150.00","tax_amount":"27.00","total":"177.00","is_paid":"0","otp":"1234","image":null}]

class Data {
  Data({
      List<LabourRequests>? labourRequests, 
      List<DeliveryRequests>? deliveryRequests,}){
    _labourRequests = labourRequests;
    _deliveryRequests = deliveryRequests;
}

  Data.fromJson(dynamic json) {
    if (json['labour_requests'] != null) {
      _labourRequests = [];
      json['labour_requests'].forEach((v) {
        _labourRequests?.add(LabourRequests.fromJson(v));
      });
    }
    if (json['delivery_requests'] != null) {
      _deliveryRequests = [];
      json['delivery_requests'].forEach((v) {
        _deliveryRequests?.add(DeliveryRequests.fromJson(v));
      });
    }
  }
  List<LabourRequests>? _labourRequests;
  List<DeliveryRequests>? _deliveryRequests;
Data copyWith({  List<LabourRequests>? labourRequests,
  List<DeliveryRequests>? deliveryRequests,
}) => Data(  labourRequests: labourRequests ?? _labourRequests,
  deliveryRequests: deliveryRequests ?? _deliveryRequests,
);
  List<LabourRequests>? get labourRequests => _labourRequests;
  List<DeliveryRequests>? get deliveryRequests => _deliveryRequests;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_labourRequests != null) {
      map['labour_requests'] = _labourRequests?.map((v) => v.toJson()).toList();
    }
    if (_deliveryRequests != null) {
      map['delivery_requests'] = _deliveryRequests?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// pickup_location : " 83, Ratna Lok Colony, Indore, Madhya Pradesh 452010, India"
/// drop_location : " 201/A, RamKrishna Bagh, Nyay Nagar NX A B Sector, Indore, Madhya Pradesh 452010, India"
/// vehicle_type : "3"
/// date : "2022-11-16"
/// time : "03:30:00"
/// category_id : "79"
/// sub_category_id : "82"
/// height : " 200"
/// length : " 300"
/// unit : " kg"
/// weight : " 20"
/// pickup_lat : " 22.7484868"
/// pickup_lng : " 75.8977327"
/// drop_lat : " 22.746151526100977"
/// drop_lng : " 75.90965900570154"
/// status : "1"
/// driver_id : "89"
/// user_id : "118"
/// rejected_by : " 89, 89, 89"
/// created_at : "2022-11-14 13:15:32"
/// updated_at : "2022-11-15 07:24:29"
/// delivery_charge : "150"
/// sub_total : "150.00"
/// tax_amount : "27.00"
/// total : "177.00"
/// is_paid : "0"
/// otp : "1234"
/// image : null

class DeliveryRequests {
  DeliveryRequests({
      String? id, 
      String? pickupLocation, 
      String? dropLocation, 
      String? vehicleType, 
      String? date, 
      String? time, 
      String? categoryId, 
      String? subCategoryId, 
      String? height, 
      String? length, 
      String? unit, 
      String? weight, 
      String? pickupLat, 
      String? pickupLng, 
      String? dropLat, 
      String? dropLng, 
      String? status, 
      String? driverId, 
      String? userId, 
      String? rejectedBy, 
      String? createdAt, 
      String? updatedAt, 
      String? deliveryCharge, 
      String? subTotal, 
      String? taxAmount, 
      String? total, 
      String? isPaid, 
      String? otp, 
      dynamic image,}){
    _id = id;
    _pickupLocation = pickupLocation;
    _dropLocation = dropLocation;
    _vehicleType = vehicleType;
    _date = date;
    _time = time;
    _categoryId = categoryId;
    _subCategoryId = subCategoryId;
    _height = height;
    _length = length;
    _unit = unit;
    _weight = weight;
    _pickupLat = pickupLat;
    _pickupLng = pickupLng;
    _dropLat = dropLat;
    _dropLng = dropLng;
    _status = status;
    _driverId = driverId;
    _userId = userId;
    _rejectedBy = rejectedBy;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deliveryCharge = deliveryCharge;
    _subTotal = subTotal;
    _taxAmount = taxAmount;
    _total = total;
    _isPaid = isPaid;
    _otp = otp;
    _image = image;
}

  DeliveryRequests.fromJson(dynamic json) {
    _id = json['id'];
    _pickupLocation = json['pickup_location'];
    _dropLocation = json['drop_location'];
    _vehicleType = json['vehicle_type'];
    _date = json['date'];
    _time = json['time'];
    _categoryId = json['category_id'];
    _subCategoryId = json['sub_category_id'];
    _height = json['height'];
    _length = json['length'];
    _unit = json['unit'];
    _weight = json['weight'];
    _pickupLat = json['pickup_lat'];
    _pickupLng = json['pickup_lng'];
    _dropLat = json['drop_lat'];
    _dropLng = json['drop_lng'];
    _status = json['status'];
    _driverId = json['driver_id'];
    _userId = json['user_id'];
    _rejectedBy = json['rejected_by'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deliveryCharge = json['delivery_charge'];
    _subTotal = json['sub_total'];
    _taxAmount = json['tax_amount'];
    _total = json['total'];
    _isPaid = json['is_paid'];
    _otp = json['otp'];
    _image = json['image'];
  }
  String? _id;
  String? _pickupLocation;
  String? _dropLocation;
  String? _vehicleType;
  String? _date;
  String? _time;
  String? _categoryId;
  String? _subCategoryId;
  String? _height;
  String? _length;
  String? _unit;
  String? _weight;
  String? _pickupLat;
  String? _pickupLng;
  String? _dropLat;
  String? _dropLng;
  String? _status;
  String? _driverId;
  String? _userId;
  String? _rejectedBy;
  String? _createdAt;
  String? _updatedAt;
  String? _deliveryCharge;
  String? _subTotal;
  String? _taxAmount;
  String? _total;
  String? _isPaid;
  String? _otp;
  dynamic _image;
DeliveryRequests copyWith({  String? id,
  String? pickupLocation,
  String? dropLocation,
  String? vehicleType,
  String? date,
  String? time,
  String? categoryId,
  String? subCategoryId,
  String? height,
  String? length,
  String? unit,
  String? weight,
  String? pickupLat,
  String? pickupLng,
  String? dropLat,
  String? dropLng,
  String? status,
  String? driverId,
  String? userId,
  String? rejectedBy,
  String? createdAt,
  String? updatedAt,
  String? deliveryCharge,
  String? subTotal,
  String? taxAmount,
  String? total,
  String? isPaid,
  String? otp,
  dynamic image,
}) => DeliveryRequests(  id: id ?? _id,
  pickupLocation: pickupLocation ?? _pickupLocation,
  dropLocation: dropLocation ?? _dropLocation,
  vehicleType: vehicleType ?? _vehicleType,
  date: date ?? _date,
  time: time ?? _time,
  categoryId: categoryId ?? _categoryId,
  subCategoryId: subCategoryId ?? _subCategoryId,
  height: height ?? _height,
  length: length ?? _length,
  unit: unit ?? _unit,
  weight: weight ?? _weight,
  pickupLat: pickupLat ?? _pickupLat,
  pickupLng: pickupLng ?? _pickupLng,
  dropLat: dropLat ?? _dropLat,
  dropLng: dropLng ?? _dropLng,
  status: status ?? _status,
  driverId: driverId ?? _driverId,
  userId: userId ?? _userId,
  rejectedBy: rejectedBy ?? _rejectedBy,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deliveryCharge: deliveryCharge ?? _deliveryCharge,
  subTotal: subTotal ?? _subTotal,
  taxAmount: taxAmount ?? _taxAmount,
  total: total ?? _total,
  isPaid: isPaid ?? _isPaid,
  otp: otp ?? _otp,
  image: image ?? _image,
);
  String? get id => _id;
  String? get pickupLocation => _pickupLocation;
  String? get dropLocation => _dropLocation;
  String? get vehicleType => _vehicleType;
  String? get date => _date;
  String? get time => _time;
  String? get categoryId => _categoryId;
  String? get subCategoryId => _subCategoryId;
  String? get height => _height;
  String? get length => _length;
  String? get unit => _unit;
  String? get weight => _weight;
  String? get pickupLat => _pickupLat;
  String? get pickupLng => _pickupLng;
  String? get dropLat => _dropLat;
  String? get dropLng => _dropLng;
  String? get status => _status;
  String? get driverId => _driverId;
  String? get userId => _userId;
  String? get rejectedBy => _rejectedBy;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deliveryCharge => _deliveryCharge;
  String? get subTotal => _subTotal;
  String? get taxAmount => _taxAmount;
  String? get total => _total;
  String? get isPaid => _isPaid;
  String? get otp => _otp;
  dynamic get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['pickup_location'] = _pickupLocation;
    map['drop_location'] = _dropLocation;
    map['vehicle_type'] = _vehicleType;
    map['date'] = _date;
    map['time'] = _time;
    map['category_id'] = _categoryId;
    map['sub_category_id'] = _subCategoryId;
    map['height'] = _height;
    map['length'] = _length;
    map['unit'] = _unit;
    map['weight'] = _weight;
    map['pickup_lat'] = _pickupLat;
    map['pickup_lng'] = _pickupLng;
    map['drop_lat'] = _dropLat;
    map['drop_lng'] = _dropLng;
    map['status'] = _status;
    map['driver_id'] = _driverId;
    map['user_id'] = _userId;
    map['rejected_by'] = _rejectedBy;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['delivery_charge'] = _deliveryCharge;
    map['sub_total'] = _subTotal;
    map['tax_amount'] = _taxAmount;
    map['total'] = _total;
    map['is_paid'] = _isPaid;
    map['otp'] = _otp;
    map['image'] = _image;
    return map;
  }

}

/// cat_name : "Industrial Labour"
/// labour_name : "Pramod"
/// labour_email : "pramodalpha@gmsil.com"
/// labour_mobile : "9111177049"
/// username : "Karan"
/// email : "karanevil.singhtomar@gmail.com"
/// mobile : "8770496665"
/// id : "21"
/// user_id : "118"
/// labour_id : "90"
/// date : "2022-11-16"
/// time : "04:08:00"
/// quantity : "4"
/// sub_total : "0.00"
/// amount : "500.00"
/// tax_amount : "0.00"
/// total : "0.00"
/// payment_status : "0"
/// payment_type : null
/// requirement : "Construction"
/// status : "0"
/// comment : null
/// created_at : "2022-11-14 10:39:34"
/// updated_at : "2022-11-14 10:39:34"

class LabourRequests {
  LabourRequests({
      String? catName, 
      String? labourName, 
      String? labourEmail, 
      String? labourMobile, 
      String? username, 
      String? email, 
      String? mobile, 
      String? id, 
      String? userId, 
      String? labourId, 
      String? date, 
      String? time, 
      String? quantity, 
      String? subTotal, 
      String? amount, 
      String? taxAmount, 
      String? total, 
      String? paymentStatus, 
      dynamic paymentType, 
      String? requirement, 
      String? status, 
      dynamic comment, 
      String? createdAt, 
      String? updatedAt,}){
    _catName = catName;
    _labourName = labourName;
    _labourEmail = labourEmail;
    _labourMobile = labourMobile;
    _username = username;
    _email = email;
    _mobile = mobile;
    _id = id;
    _userId = userId;
    _labourId = labourId;
    _date = date;
    _time = time;
    _quantity = quantity;
    _subTotal = subTotal;
    _amount = amount;
    _taxAmount = taxAmount;
    _total = total;
    _paymentStatus = paymentStatus;
    _paymentType = paymentType;
    _requirement = requirement;
    _status = status;
    _comment = comment;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  LabourRequests.fromJson(dynamic json) {
    _catName = json['cat_name'];
    _labourName = json['labour_name'];
    _labourEmail = json['labour_email'];
    _labourMobile = json['labour_mobile'];
    _username = json['username'];
    _email = json['email'];
    _mobile = json['mobile'];
    _id = json['id'];
    _userId = json['user_id'];
    _labourId = json['labour_id'];
    _date = json['date'];
    _time = json['time'];
    _quantity = json['quantity'];
    _subTotal = json['sub_total'];
    _amount = json['amount'];
    _taxAmount = json['tax_amount'];
    _total = json['total'];
    _paymentStatus = json['payment_status'];
    _paymentType = json['payment_type'];
    _requirement = json['requirement'];
    _status = json['status'];
    _comment = json['comment'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _catName;
  String? _labourName;
  String? _labourEmail;
  String? _labourMobile;
  String? _username;
  String? _email;
  String? _mobile;
  String? _id;
  String? _userId;
  String? _labourId;
  String? _date;
  String? _time;
  String? _quantity;
  String? _subTotal;
  String? _amount;
  String? _taxAmount;
  String? _total;
  String? _paymentStatus;
  dynamic _paymentType;
  String? _requirement;
  String? _status;
  dynamic _comment;
  String? _createdAt;
  String? _updatedAt;
LabourRequests copyWith({  String? catName,
  String? labourName,
  String? labourEmail,
  String? labourMobile,
  String? username,
  String? email,
  String? mobile,
  String? id,
  String? userId,
  String? labourId,
  String? date,
  String? time,
  String? quantity,
  String? subTotal,
  String? amount,
  String? taxAmount,
  String? total,
  String? paymentStatus,
  dynamic paymentType,
  String? requirement,
  String? status,
  dynamic comment,
  String? createdAt,
  String? updatedAt,
}) => LabourRequests(  catName: catName ?? _catName,
  labourName: labourName ?? _labourName,
  labourEmail: labourEmail ?? _labourEmail,
  labourMobile: labourMobile ?? _labourMobile,
  username: username ?? _username,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  id: id ?? _id,
  userId: userId ?? _userId,
  labourId: labourId ?? _labourId,
  date: date ?? _date,
  time: time ?? _time,
  quantity: quantity ?? _quantity,
  subTotal: subTotal ?? _subTotal,
  amount: amount ?? _amount,
  taxAmount: taxAmount ?? _taxAmount,
  total: total ?? _total,
  paymentStatus: paymentStatus ?? _paymentStatus,
  paymentType: paymentType ?? _paymentType,
  requirement: requirement ?? _requirement,
  status: status ?? _status,
  comment: comment ?? _comment,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get catName => _catName;
  String? get labourName => _labourName;
  String? get labourEmail => _labourEmail;
  String? get labourMobile => _labourMobile;
  String? get username => _username;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get id => _id;
  String? get userId => _userId;
  String? get labourId => _labourId;
  String? get date => _date;
  String? get time => _time;
  String? get quantity => _quantity;
  String? get subTotal => _subTotal;
  String? get amount => _amount;
  String? get taxAmount => _taxAmount;
  String? get total => _total;
  String? get paymentStatus => _paymentStatus;
  dynamic get paymentType => _paymentType;
  String? get requirement => _requirement;
  String? get status => _status;
  dynamic get comment => _comment;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cat_name'] = _catName;
    map['labour_name'] = _labourName;
    map['labour_email'] = _labourEmail;
    map['labour_mobile'] = _labourMobile;
    map['username'] = _username;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['id'] = _id;
    map['user_id'] = _userId;
    map['labour_id'] = _labourId;
    map['date'] = _date;
    map['time'] = _time;
    map['quantity'] = _quantity;
    map['sub_total'] = _subTotal;
    map['amount'] = _amount;
    map['tax_amount'] = _taxAmount;
    map['total'] = _total;
    map['payment_status'] = _paymentStatus;
    map['payment_type'] = _paymentType;
    map['requirement'] = _requirement;
    map['status'] = _status;
    map['comment'] = _comment;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}