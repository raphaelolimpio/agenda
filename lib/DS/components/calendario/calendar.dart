import 'package:agenda/DS/components/calendario/calendario_view_model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  final CalendarioViewModel viewModel;

  const Calendar({super.key, required this.viewModel});

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  bool _isDayView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.viewModel.title)),
      body: Column(
        children: [
          if (!_isDayView)
            TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2050, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _isDayView = true;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
            )
          else
            _buildDayView(),
        ],
      ),
    );
  }

  Widget _buildDayView() {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.viewModel.endHour - widget.viewModel.startHour + 1,
        itemBuilder: (context, index) {
          int hour = widget.viewModel.startHour + index;
          return ListTile(
            title: Text('$hour:00'),
            onTap: () {
              // Dispara callback ao selecionar um horário
              if (widget.viewModel.onDateTimeSelected != null) {
                widget.viewModel.onDateTimeSelected!(_selectedDay, hour);
              }
            },
          );
        },
      ),
    );
  }
}
