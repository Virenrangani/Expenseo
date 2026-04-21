import 'package:flutter/cupertino.dart';
import '../../constant/string/app_string.dart';

class AppTitle extends StatelessWidget {

  final TextStyle style;

   AppTitle({
    super.key,
    required this.style
  });

  @override
  Widget build(BuildContext context) {
    return Text(AppString.appName,style: style,);
  }
}
