import 'dart:ui';
extension DeviceSizes on num {
  double get h => this *  window.physicalSize.height /  window.devicePixelRatio / 100 ;
  double get w => this *  window.physicalSize.width /  window.devicePixelRatio / 100 ;
}
