import 'dart:convert';
import 'package:get/get.dart';
import 'package:racrally/models/user_model.dart';
import 'package:racrally/routes/app_routes.dart';
import 'package:racrally/utils/snackbar_utils.dart';
import '../../../api_services/api_exceptions.dart';
import '../../../api_services/data_api.dart';
import '../../../controllers/base_controller.dart';
import '../../../services/local_storage/shared_preferences.dart';
import '../../../utils/custom_dialog.dart';

class AuthController extends GetxController {
  final AuthPreference _authPreference = AuthPreference.instance;

  RxString accessToken = "".obs;
  RxString signUpOtp = "".obs;
  RxBool showCheck = false.obs;
  RxBool showPassword = false.obs;
  RxString checkedItem = ''.obs;
  final BaseController _baseController = BaseController.instance;
  Rxn<UserModel> userData=Rxn<UserModel>();

  Future loginUser(String email,String password,bool rememberMe) async {
    _baseController.showLoading();
    print("entry 1");
    Map<String, String> body = {
      "email":email,
      "password":password
    };
    print("entry 2");
    var response = await DataApiService.instance
        .post('/login', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(
            title: 'Error!', showTitle: true, description: apiError["reason"]);
      } else {
        _baseController.handleError(error);
      }
    });
    print("entry 3");
    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response + " responded");

    var result = json.decode(response);
    if (result['success'].toString()=="true") {
      userData.value=UserModel.fromJson(result['data']);
      accessToken.value=result['data']['token'];
      _authPreference.saveUserData(data: jsonEncode(userData.value?.toJson()));
      print("${jsonEncode(userData.value?.toJson())} this is user data");
      _authPreference.saveUserDataToken(token: accessToken.value);
      Get.offAndToNamed(AppRoutes.bottomBar);
      if(rememberMe==true){
        _authPreference.setUserLoggedIn(true);
      }
      // Handle success case
    } else if(result['status'].toString()=="failed"&&result['error'].toString()=="true") {
      print("error is here");
      String message = result['data']['message'];
      if(result['data']['message']=="Verification pending, please verify your email first"){
        Get.toNamed(AppRoutes.signUp);
      }
      SnackbarUtil.showSnackbar(message: message, type: SnackbarType.error);
    }
  }

  Future verifyEmail(String otp) async {
    _baseController.showLoading();
    Map<String, String> body = {
      "otp":otp
    };

    var response = await DataApiService.instance
        .post('/verify-otp', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(
            title: 'Error!', showTitle: true, description: apiError["reason"]);
      } else {
        _baseController.handleError(error);
      }
    });

    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response + " responded");

    var result = json.decode(response);
    if (result['success'].toString()=="true") {
      Get.toNamed(AppRoutes.login);

      // Handle success case
    } else if(result['status'].toString()=="failed"&&result['error'].toString()=="true") {
      print("error is here");
      String message = result['data']['message'];
      SnackbarUtil.showSnackbar(message: message, type: SnackbarType.error);
    }
  }

  Future signUpUser(String firstName, String lastName, String email,
      String password, String gender) async {
    _baseController.showLoading();
    Map<String, String> body = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "gender": gender,
      "role": "Admin"
    };

    var response = await DataApiService.instance
        .post('/signup', body)
        .catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        CustomDialog.showErrorDialog(
            title: 'Error!', showTitle: true, description: apiError["reason"]);
      } else {
        _baseController.handleError(error);
      }
    });

    update();
    _baseController.hideLoading();
    if (response == null) return;
    print(response + " responded");

    var result = json.decode(response);
    if (result['success'].toString()=="true" && result['message']=="Successful") {
      Get.toNamed(AppRoutes.verifyOtp);
      print("logged in");
      accessToken.value=result['data']['token'];
      signUpOtp.value=result['data']['otp'];
      SnackbarUtil.showSnackbar(message: signUpOtp.value, type: SnackbarType.success);
      print(accessToken.value);
      print(signUpOtp.value);
      // Handle success case
    } else if(result['status'].toString()=="failed"&&result['error'].toString()=="true"){
      print("error is here");
      String message = result['data']['message'];
      SnackbarUtil.showSnackbar(message: message, type: SnackbarType.error);
    }
  }

  void setCheck(String? value) {
    checkedItem.value = value ?? '';
  }

  void toggleCheck() {
    showCheck.value = !showCheck.value;
  }

  void togglePassword() {
    showPassword.value = !showPassword.value;
  }
}