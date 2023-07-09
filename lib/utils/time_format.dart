import 'package:intl/intl.dart';

String formatTimestamp(timestamp) {
  final now = DateTime.now();
  final postTime = timestamp.toDate();
  final difference = now.difference(postTime);

  if (difference.inSeconds < 60) {
    return 'Just now';
  } else if (difference.inMinutes < 1) {
    return '${difference.inSeconds} Seconds ago';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} Min ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'Hour' : 'Hours'} ago';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} ${difference.inDays == 1 ? 'Day' : 'Days'} ago';
  } else if (difference.inDays < 30) {
    final weeks = (difference.inDays / 7).floor();
    return '$weeks ${weeks == 1 ? 'Week' : 'Weeks'} ago';
  } else {
    return DateFormat.yMMMd().format(postTime);
  }
}
