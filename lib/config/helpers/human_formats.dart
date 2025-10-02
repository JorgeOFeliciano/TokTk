import 'package:intl/intl.dart';

class HumanFormats {
  //Método estático no requiere instanciar la clase
  static String humanReadableNumber(double number) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
    ).format(number);
    return (formattedNumber);
  }
}