import 'package:intl/intl.dart';

extension Currency on String {
  String get currencyFormat {
    final amountNumber = double.parse(this);
    if (amountNumber == null) return 'Rp -';
    final currency = NumberFormat.compact();

    return currency.format(amountNumber);
  }
}
