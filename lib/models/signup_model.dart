/// response_code : "1"
/// message : "user register success"
/// status : "success"
/// user : true
/// otp : 9141

class SignupModel {
  SignupModel({
      String? responseCode, 
      String? message, 
      String? status, 
      bool? user, 
      String? otp,}){
    _responseCode = responseCode;
    _message = message;
    _status = status;
    _user = user;
    _otp = otp;
}

  SignupModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _status = json['status'];
    _user = json['user'];
    _otp = json['otp'];
  }
  String? _responseCode;
  String? _message;
  String? _status;
  bool? _user;
  String? _otp;
SignupModel copyWith({  String? responseCode,
  String? message,
  String? status,
  bool? user,
  String? otp,
}) => SignupModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  status: status ?? _status,
  user: user ?? _user,
  otp: otp ?? _otp,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  String? get status => _status;
  bool? get user => _user;
  String? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    map['status'] = _status;
    map['user'] = _user;
    map['otp'] = _otp;
    return map;
  }

}