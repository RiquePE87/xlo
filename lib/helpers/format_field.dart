import 'package:intl/intl.dart';

String getSanitizedText(String text) {
  return text.replaceAll(RegExp(r'[^\d]'), "");
}

String numToString(num price) {
  return NumberFormat("###,##0.00", "pt-br")
      .format(double.parse(price.toStringAsFixed(2)));
}

String dateToString(DateTime date){
  return DateFormat("dd/MM HH:mm", "pt-br").format(date);
}