import '../api_services/api_exceptions.dart';
import '../utils/custom_dialog.dart';
import '../utils/snackbar_utils.dart';


class BaseController {
  BaseController._();

  static final BaseController _instance = BaseController._();
  static BaseController get instance => _instance;
  void handleError(error) {
    hideLoading();
    if (error is BadRequestException) {
      var message = error.message;
      SnackbarUtil.showSnackbar(message: message!, type: SnackbarType.error);
    } else if (error is FetchDataException) {
      var message = error.message;
      SnackbarUtil.showSnackbar(message: message!, type: SnackbarType.error);
    } else if (error is ApiNotRespondingException) {
      SnackbarUtil.showSnackbar(message: 'Oops! It took longer to respond.', type: SnackbarType.error);
    }
  }

  showLoading([String? message]) {
    CustomDialog.showLoading(message);
  }

  hideLoading() {
    CustomDialog.hideLoading();
  }
}
