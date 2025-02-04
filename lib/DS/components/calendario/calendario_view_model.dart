enum CalendarioSize { small, medium, large }

enum CalendarioStyleColor { redColor, greenColor, cyanColor }

class CalendarioViewModel {
  final CalendarioSize size;
  final CalendarioStyleColor style;
  final String title;
  final Function(DateTime, int)? onDateTimeSelected;
  final int startHour;
  final int endHour;

  CalendarioViewModel({
    required this.size,
    required this.style,
    required this.title,
    this.onDateTimeSelected,
    required this.startHour,
    required this.endHour,
  });
}
