import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoding => _isLoading;

  showLoader() {
    _isLoading = true;
    notifyListeners();
  }

  hideLoader() {
    _isLoading = false;
    notifyListeners();
  }
}
