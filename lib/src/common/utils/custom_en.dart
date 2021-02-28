import 'package:timeago/timeago.dart' as timeago;

class CustomEn extends timeago.EnMessages {
  @override
  String suffixAgo() => '';
  String minutes(int minutes) => '${minutes}m';
  String hours(int hours) => '${hours}h';
  String days(int days) => '${days}d';
}