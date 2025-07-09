// import 'dart:convert';
//
// import 'package:get/get.dart';
//
// import '../api_services/api_exceptions.dart';
// import '../api_services/data_api.dart';
// import '../utils/custom_dialog.dart';
// import 'base_controller.dart';
//
// class AuthController extends GetxController {
//   RxString accessToken = "".obs;
//   final BaseController _baseController = BaseController.instance;
//   Future loginUser(bool isFromLogin) async {
//     // _baseController.showLoading();
//     Map<String, String> body = {
//       'email': "emailController.text.toString()",
//       'password': "passwordController.text.toString()"
//     };
//     var response = await DataApiService.instance
//         .post('user/login', body)
//         .catchError((error) {
//       if (error is BadRequestException) {
//         var apiError = json.decode(error.message!);
//         // CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: apiError["reason"]);
//       } else {
//         _baseController.handleError(error);
//       }
//     });
//     update();
//     _baseController.hideLoading();
//     if (response == null) return;
//     print(response+ "responded");
//     // print(result['success'])
//     var result = json.decode(response);
//     if (result['success']) {
//
//     } else {
//       // custom dialog
//       // List<dynamic> errorMessage=result['message'];
//       // String message=errorMessage.join();
//       // CustomDialog.showErrorDialog(title: 'Error!', showTitle: true,description: message);
//
//     }
//   }
// }