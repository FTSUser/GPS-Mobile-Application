import 'package:intl/intl.dart';

class CustomDateFormator {
  CustomDateFormator._();

  static dateFormatByMonthName(String? date){
    return  DateFormat('dd MMM yyyy').format(
        DateTime.parse(date!).toLocal()
    ).toString();
  }
}