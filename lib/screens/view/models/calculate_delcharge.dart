/// response_code : "1"
/// message : "Delivery Charge found"
/// status : "success"
/// distance : "0.08"
/// per_km_charge : "120.00"
/// charge : "9.60"
/// data : "9.60"

class CalculateDelcharge {
  CalculateDelcharge({
      String? responseCode, 
      String? message, 
      String? status, 
      String? distance, 
      String? perKmCharge, 
      String? charge, 
      String? data,}){
    _responseCode = responseCode;
    _message = message;
    _status = status;
    _distance = distance;
    _perKmCharge = perKmCharge;
    _charge = charge;
    _data = data;
}

  CalculateDelcharge.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _status = json['status'];
    _distance = json['distance'];
    _perKmCharge = json['per_km_charge'];
    _charge = json['charge'];
    _data = json['data'];
  }
  String? _responseCode;
  String? _message;
  String? _status;
  String? _distance;
  String? _perKmCharge;
  String? _charge;
  String? _data;
CalculateDelcharge copyWith({  String? responseCode,
  String? message,
  String? status,
  String? distance,
  String? perKmCharge,
  String? charge,
  String? data,
}) => CalculateDelcharge(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  status: status ?? _status,
  distance: distance ?? _distance,
  perKmCharge: perKmCharge ?? _perKmCharge,
  charge: charge ?? _charge,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  String? get status => _status;
  String? get distance => _distance;
  String? get perKmCharge => _perKmCharge;
  String? get charge => _charge;
  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    map['status'] = _status;
    map['distance'] = _distance;
    map['per_km_charge'] = _perKmCharge;
    map['charge'] = _charge;
    map['data'] = _data;
    return map;
  }

}