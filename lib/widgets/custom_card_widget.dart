import 'package:flutter/material.dart';
import 'package:uptime_code/core/device_size.dart';
class CustomCardWidget extends StatelessWidget {
  final String title;
  final VoidCallback onClick;
  const CustomCardWidget({Key? key, required this.title, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onClick,
        child: Container(
          height: 20.h,
          width: 20.w,
          color: Colors.blue,
          child: Center(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
  }
}
