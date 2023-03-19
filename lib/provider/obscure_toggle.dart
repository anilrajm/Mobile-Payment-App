import 'package:recharge_app_mega/views/views.dart';

class ObscureToggleProvider with ChangeNotifier{
  bool _passwordVisibility = true;
  bool get passwordVisibility=>_passwordVisibility;

  void setObscure(){
    _passwordVisibility = !_passwordVisibility;
    notifyListeners();
  }
}