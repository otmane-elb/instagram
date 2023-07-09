import 'package:intl/intl.dart';

String formatTimestamp(timestamp) {
  final now = DateTime.now();
  final postTime = timestamp.toDate();
  final difference = now.difference(postTime);

  if (difference.inSeconds < 60) {
    return 'just now';
  } else if (difference.inMinutes < 1) {
    return '${difference.inSeconds} seconds ago';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} min ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
  } else if (difference.inDays < 30) {
    final weeks = (difference.inDays / 7).floor();
    return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
  } else {
    return DateFormat.yMMMd().format(postTime);
  }
}
