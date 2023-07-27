import 'package:ez/models/signup_model.dart';
import 'package:ez/models/signup_otp_model.dart';
import 'package:ez/repositary/repositary.dart';
import 'package:rxdart/rxdart.dart';

class SignupBloc {
  final _signupBlocController = PublishSubject<SignupModel>();
  final _signupOtpBlocController = PublishSubject<SignupOtpModel>();
  //Observable<signupModel> get signupStream => _signupBlocController.stream;

  Future<SignupModel> signupSink(
    String email,
    String password,
    String username,
      String mobile,
  ) async {
    return await Repository().signupRepository(
      email,
      password,
      username,
      mobile,
    );
  }
  Future<SignupOtpModel> signupOtpSink(
      String email,
      String password,
      String username,
      String mobile,
      ) async {
    return await Repository().signupOtpRepository(
      email,
      password,
      username,
      mobile,
    );
  }

  dispose() {
    _signupBlocController.close();
    _signupOtpBlocController.close();
  }
}

final signupBloc = SignupBloc();
