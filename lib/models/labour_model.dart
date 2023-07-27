/// response_code : "1"
/// msg : "Labour Found"
/// status : "success"
/// labour : [{"category_name":"Industrial Labour","id":"73","email":"devesh@gmail.com","mobile":"8349922853","address":"","description":"hello","category_id":"76","per_d_charge":"450","experience_id":"1","experience":"2","vehicle_number":null,"vehicle_type":null,"rc_book":null,"per_km_charge":null,"lat":"0","lang":"0","uname":"devesh","password":"","profile_image":"636373408e61b.jpg","device_token":"","otp":null,"status":"1","wallet":"0.00","balance":"0.00","last_login":null,"created_at":"2022-11-03 00:52:32","updated_at":"2022-11-03 02:19:52","roll":"1","adhar_card":"636373408d993.jpg","pancard":"636373408e4f0.jpg"}]

class LabourModel {
  LabourModel({
      String? responseCode,
      String? msg,
      String? status,
      List<Labour>? labour,}){
    _responseCode = responseCode;
    _msg = msg;
    _status = status;
    _labour = labour;
}

  LabourModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _msg = json['msg'];
    _status = json['status'];
    if (json['labour'] != null) {
      _labour = [];
      json['labour'].forEach((v) {
        _labour?.add(Labour.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _msg;
  String? _status;
  List<Labour>? _labour;
LabourModel copyWith({  String? responseCode,
  String? msg,
  String? status,
  List<Labour>? labour,
}) => LabourModel(  responseCode: responseCode ?? _responseCode,
  msg: msg ?? _msg,
  status: status ?? _status,
  labour: labour ?? _labour,
);
  String? get responseCode => _responseCode;
  String? get msg => _msg;
  String? get status => _status;
  List<Labour>? get labour => _labour;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['msg'] = _msg;
    map['status'] = _status;
    if (_labour != null) {
      map['labour'] = _labour?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// category_name : "Industrial Labour"
/// id : "73"
/// email : "devesh@gmail.com"
/// mobile : "8349922853"
/// address : ""
/// description : "hello"
/// category_id : "76"
/// per_d_charge : "450"
/// experience_id : "1"
/// experience : "2"
/// vehicle_number : null
/// vehicle_type : null
/// rc_book : null
/// per_km_charge : null
/// lat : "0"
/// lang : "0"
/// uname : "devesh"
/// password : ""
/// profile_image : "636373408e61b.jpg"
/// device_token : ""
/// otp : null
/// status : "1"
/// wallet : "0.00"
/// balance : "0.00"
/// last_login : null
/// created_at : "2022-11-03 00:52:32"
/// updated_at : "2022-11-03 02:19:52"
/// roll : "1"
/// adhar_card : "636373408d993.jpg"
/// pancard : "636373408e4f0.jpg"

class Labour {
  Labour({
      String? categoryName,
      String? id,
      String? email,
      String? mobile,
      String? address,
      String? description,
      String? categoryId,
      String? perDCharge,
      String? experienceId,
      String? experience,
      dynamic vehicleNumber,
      dynamic vehicleType,
      dynamic rcBook,
      dynamic perKmCharge,
      String? lat,
      String? lang,
      String? uname,
      String? password,
      String? profileImage,
      String? deviceToken,
      dynamic otp,
      String? status,
      String? wallet,
      String? balance,
      dynamic lastLogin,
      String? createdAt,
      String? updatedAt,
      String? roll,
      String? adharCard,
      String? pancard,}){
    _categoryName = categoryName;
    _id = id;
    _email = email;
    _mobile = mobile;
    _address = address;
    _description = description;
    _categoryId = categoryId;
    _perDCharge = perDCharge;
    _experienceId = experienceId;
    _experience = experience;
    _vehicleNumber = vehicleNumber;
    _vehicleType = vehicleType;
    _rcBook = rcBook;
    _perKmCharge = perKmCharge;
    _lat = lat;
    _lang = lang;
    _uname = uname;
    _password = password;
    _profileImage = profileImage;
    _deviceToken = deviceToken;
    _otp = otp;
    _status = status;
    _wallet = wallet;
    _balance = balance;
    _lastLogin = lastLogin;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _roll = roll;
    _adharCard = adharCard;
    _pancard = pancard;
}

  Labour.fromJson(dynamic json) {
    _categoryName = json['category_name'];
    _id = json['id'];
    _email = json['email'];
    _mobile = json['mobile'];
    _address = json['address'];
    _description = json['description'];
    _categoryId = json['category_id'];
    _perDCharge = json['per_d_charge'];
    _experienceId = json['experience_id'];
    _experience = json['experience'];
    _vehicleNumber = json['vehicle_number'];
    _vehicleType = json['vehicle_type'];
    _rcBook = json['rc_book'];
    _perKmCharge = json['per_km_charge'];
    _lat = json['lat'];
    _lang = json['lang'];
    _uname = json['uname'];
    _password = json['password'];
    _profileImage = json['profile_image'];
    _deviceToken = json['device_token'];
    _otp = json['otp'];
    _status = json['status'];
    _wallet = json['wallet'];
    _balance = json['balance'];
    _lastLogin = json['last_login'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _roll = json['roll'];
    _adharCard = json['adhar_card'];
    _pancard = json['pancard'];
  }
  String? _categoryName;
  String? _id;
  String? _email;
  String? _mobile;
  String? _address;
  String? _description;
  String? _categoryId;
  String? _perDCharge;
  String? _experienceId;
  String? _experience;
  dynamic _vehicleNumber;
  dynamic _vehicleType;
  dynamic _rcBook;
  dynamic _perKmCharge;
  String? _lat;
  String? _lang;
  String? _uname;
  String? _password;
  String? _profileImage;
  String? _deviceToken;
  dynamic _otp;
  String? _status;
  String? _wallet;
  String? _balance;
  dynamic _lastLogin;
  String? _createdAt;
  String? _updatedAt;
  String? _roll;
  String? _adharCard;
  String? _pancard;
Labour copyWith({  String? categoryName,
  String? id,
  String? email,
  String? mobile,
  String? address,
  String? description,
  String? categoryId,
  String? perDCharge,
  String? experienceId,
  String? experience,
  dynamic vehicleNumber,
  dynamic vehicleType,
  dynamic rcBook,
  dynamic perKmCharge,
  String? lat,
  String? lang,
  String? uname,
  String? password,
  String? profileImage,
  String? deviceToken,
  dynamic otp,
  String? status,
  String? wallet,
  String? balance,
  dynamic lastLogin,
  String? createdAt,
  String? updatedAt,
  String? roll,
  String? adharCard,
  String? pancard,
}) => Labour(  categoryName: categoryName ?? _categoryName,
  id: id ?? _id,
  email: email ?? _email,
  mobile: mobile ?? _mobile,
  address: address ?? _address,
  description: description ?? _description,
  categoryId: categoryId ?? _categoryId,
  perDCharge: perDCharge ?? _perDCharge,
  experienceId: experienceId ?? _experienceId,
  experience: experience ?? _experience,
  vehicleNumber: vehicleNumber ?? _vehicleNumber,
  vehicleType: vehicleType ?? _vehicleType,
  rcBook: rcBook ?? _rcBook,
  perKmCharge: perKmCharge ?? _perKmCharge,
  lat: lat ?? _lat,
  lang: lang ?? _lang,
  uname: uname ?? _uname,
  password: password ?? _password,
  profileImage: profileImage ?? _profileImage,
  deviceToken: deviceToken ?? _deviceToken,
  otp: otp ?? _otp,
  status: status ?? _status,
  wallet: wallet ?? _wallet,
  balance: balance ?? _balance,
  lastLogin: lastLogin ?? _lastLogin,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  roll: roll ?? _roll,
  adharCard: adharCard ?? _adharCard,
  pancard: pancard ?? _pancard,
);
  String? get categoryName => _categoryName;
  String? get id => _id;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get address => _address;
  String? get description => _description;
  String? get categoryId => _categoryId;
  String? get perDCharge => _perDCharge;
  String? get experienceId => _experienceId;
  String? get experience => _experience;
  dynamic get vehicleNumber => _vehicleNumber;
  dynamic get vehicleType => _vehicleType;
  dynamic get rcBook => _rcBook;
  dynamic get perKmCharge => _perKmCharge;
  String? get lat => _lat;
  String? get lang => _lang;
  String? get uname => _uname;
  String? get password => _password;
  String? get profileImage => _profileImage;
  String? get deviceToken => _deviceToken;
  dynamic get otp => _otp;
  String? get status => _status;
  String? get wallet => _wallet;
  String? get balance => _balance;
  dynamic get lastLogin => _lastLogin;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get roll => _roll;
  String? get adharCard => _adharCard;
  String? get pancard => _pancard;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_name'] = _categoryName;
    map['id'] = _id;
    map['email'] = _email;
    map['mobile'] = _mobile;
    map['address'] = _address;
    map['description'] = _description;
    map['category_id'] = _categoryId;
    map['per_d_charge'] = _perDCharge;
    map['experience_id'] = _experienceId;
    map['experience'] = _experience;
    map['vehicle_number'] = _vehicleNumber;
    map['vehicle_type'] = _vehicleType;
    map['rc_book'] = _rcBook;
    map['per_km_charge'] = _perKmCharge;
    map['lat'] = _lat;
    map['lang'] = _lang;
    map['uname'] = _uname;
    map['password'] = _password;
    map['profile_image'] = _profileImage;
    map['device_token'] = _deviceToken;
    map['otp'] = _otp;
    map['status'] = _status;
    map['wallet'] = _wallet;
    map['balance'] = _balance;
    map['last_login'] = _lastLogin;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['roll'] = _roll;
    map['adhar_card'] = _adharCard;
    map['pancard'] = _pancard;
    return map;
  }

}