import 'package:flutter/cupertino.dart';

class MaterialAppResources extends ChangeNotifier {
  bool isOpenGrid = false;
  bool isShowBanner = false;
  bool isShowPerformance = false;
  bool isShowPaint = false;
  bool isRepaintRainbow = false;

  void upDateShowGrid() {
    isOpenGrid = !isOpenGrid;
    notifyListeners();
  }

  void upDateShowBanner() {
    isShowBanner = !isShowBanner;
    notifyListeners();
  }

  void upDateShowPerformance() {
    isShowPerformance = !isShowPerformance;
    notifyListeners();
  }

  void upDateShowPaint() {
    isShowPaint = !isShowPaint;
    notifyListeners();
  }

  void upDateRepaintRainbow() {
    isRepaintRainbow = !isRepaintRainbow;
    notifyListeners();
  }

  void forceSetSate() {
    notifyListeners();
  }
}
