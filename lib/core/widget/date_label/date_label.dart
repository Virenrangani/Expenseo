String dateLabel(DateTime dt) {
  final now   = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final date  = DateTime(dt.year, dt.month, dt.day);
  if (date == today) return 'Today';
  if (date == today.subtract(const Duration(days: 1))) return 'Yesterday';
  return '${dt.day} ${month(dt.month)} ${dt.year}';
}

String month(int m) => const [
  '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
][m];