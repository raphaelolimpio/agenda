enum CalendarioSize { small, medium, large }

enum ListEvents { True, False }

enum CalendarioStyleColor { redColor, greenColor, cyanColor }

class CalendarioViewModel {
  final CalendarioSize size;
  final CalendarioStyleColor style;
  final String title;
  final Function(DateTime, int)? onDateTimeSelected;
  final int startHour;
  final int endHour;
  final ListEvents listEvents;
  final bool isWeekView;

  CalendarioViewModel({
    required this.size,
    required this.style,
    required this.title,
    this.onDateTimeSelected,
    required this.startHour,
    required this.endHour,
    required this.listEvents,
    required this.isWeekView,
  });
}
