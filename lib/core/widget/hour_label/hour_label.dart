String hourLabel(int hour) {
  if (hour == 0)  return '12 AM';
  if (hour < 12)  return '${hour.toString().padLeft(2, '0')} AM';
  if (hour == 12) return '12 PM';
  return '${(hour - 12).toString().padLeft(2, '0')} PM';
}