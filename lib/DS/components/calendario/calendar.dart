import 'package:agenda/DS/components/calendario/calendario_view_model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

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
  bool _isYearView = false;
  List<String> _events = [];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDarkMode ? Colors.blueAccent : Colors.blue;
    final bgColor = isDarkMode ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          widget.viewModel.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        leading: (_isDayView || _isYearView)
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _isDayView = false;
                    _isYearView = false;
                  });
                },
              )
            : null,
        actions: [
          if (!_isDayView)
            IconButton(
              icon: Icon(
                _isYearView ? Icons.calendar_month : Icons.calendar_today,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _isYearView = !_isYearView;
                });
              },
            ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _isYearView
            ? _buildYearView()
            : (_isDayView ? _buildDayView() : _buildCalendarView()),
      ),
    );
  }

  Widget _buildCalendarView() {
    return Column(
      children: [
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
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        if (widget.viewModel.listEvents == ListEvents.True) _buildEventList(),
      ],
    );
  }

  Widget _buildYearView() {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = (constraints.maxWidth ~/ 120).clamp(3, 6);

              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  DateTime month = DateTime(_focusedDay.year, index + 1, 1);
                  bool isCurrentMonth = month.month == DateTime.now().month;

                  return _buildMonthTile(month, isCurrentMonth);
                },
              );
            },
          ),
        ),
        const Divider(height: 2, thickness: 2),
        Expanded(
          flex: 3,
          child: _buildEventListForYear(),
        ),
      ],
    );
  }

  Widget _buildEventListForYear() {
    List<Map<String, dynamic>> yearEvents =
        _filterEvents(selectedDate: _focusedDay, filter: "year");

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Todos os eventos de ${_focusedDay.year}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Expanded(
          child: yearEvents.isEmpty
              ? const Center(child: Text("Nenhum evento para este ano"))
              : ListView.builder(
                  itemCount: yearEvents.length,
                  itemBuilder: (context, index) {
                    var event = yearEvents[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      elevation: 3,
                      child: ListTile(
                        leading: const Icon(Icons.event, color: Colors.blue),
                        title: Text(event['name']),
                        subtitle: Text(
                          DateFormat('dd/MM/yyyy').format(event['date']),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getAllEventsSorted() {
    Map<int, List<String>> eventsByMonth = {
      1: ["Ano Novo", "Férias escolares"],
      2: ["Carnaval", "Aniversário do João"],
      3: ["Reunião trimestral"],
      4: ["Páscoa", "Treinamento corporativo"],
      5: ["Dia das Mães", "Festa da empresa"],
      6: ["Férias de meio de ano"],
      7: ["Workshop de tecnologia"],
      8: ["Festa de aniversário"],
      9: ["Congresso nacional"],
      10: ["Halloween", "Feira de ciências"],
      11: ["Black Friday", "Treinamento interno"],
      12: ["Natal", "Reveillon"],
    };

    List<Map<String, dynamic>> allEvents = [];

    eventsByMonth.forEach((month, events) {
      for (var event in events) {
        allEvents.add({
          'name': event,
          'date': DateTime(_focusedDay.year, month, 1),
        });
      }
    });

    allEvents.sort((a, b) => a['date'].compareTo(b['date']));

    return allEvents;
  }

  Widget _buildMonthTile(DateTime month, bool isCurrentMonth) {
    List<Map<String, dynamic>> monthEvents =
        _filterEvents(selectedDate: month, filter: "month");

    return GestureDetector(
      onTap: () {
        setState(() {
          _isYearView = false;
          _focusedDay = month;
        });
      },
      child: Card(
        elevation: 4,
        color: isCurrentMonth ? Colors.blue.shade100 : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat.MMMM('pt_BR').format(month),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isCurrentMonth ? Colors.blue : Colors.black,
              ),
            ),
            const SizedBox(height: 6),
            Text("${month.year}", style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 6),
            Text(
              "${monthEvents.length} eventos",
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventList() {
    List<Map<String, dynamic>> dayEvents =
        _filterEvents(selectedDate: _selectedDay, filter: "day");

    return Expanded(
      child: Column(
        children: [
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Eventos para ${DateFormat.yMMMMd('pt_BR').format(_selectedDay)}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            child: dayEvents.isEmpty
                ? const Center(child: Text("Nenhum evento para este dia"))
                : ListView.builder(
                    itemCount: dayEvents.length,
                    itemBuilder: (context, index) => Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      elevation: 3,
                      child: ListTile(
                        leading: const Icon(Icons.event, color: Colors.blue),
                        title: Text(dayEvents[index]['name']),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayView() {
    return ListView.builder(
      itemCount: widget.viewModel.endHour - widget.viewModel.startHour + 1,
      itemBuilder: (context, index) {
        int hour = widget.viewModel.startHour + index;
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          elevation: 3,
          child: ListTile(
            leading: const Icon(Icons.schedule, color: Colors.blue),
            title: Text('$hour:00'),
            onTap: () {
              widget.viewModel.onDateTimeSelected?.call(_selectedDay, hour);
            },
          ),
        );
      },
    );
  }

  List<Map<String, dynamic>> _filterEvents(
      {DateTime? selectedDate, String filter = "year"}) {
    List<Map<String, dynamic>> allEvents = _getAllEventsSorted();

    switch (filter) {
      case "year":
        return allEvents
            .where((event) => event['date'].year == selectedDate?.year)
            .toList();

      case "month":
        return allEvents
            .where((event) =>
                event['date'].year == selectedDate?.year &&
                event['date'].month == selectedDate?.month)
            .toList();

      case "week":
        DateTime startOfWeek =
            selectedDate!.subtract(Duration(days: selectedDate.weekday - 1));
        DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

        return allEvents
            .where((event) =>
                event['date']
                    .isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
                event['date'].isBefore(endOfWeek.add(const Duration(days: 1))))
            .toList();

      case "day":
        return allEvents
            .where((event) =>
                event['date'].year == selectedDate?.year &&
                event['date'].month == selectedDate?.month &&
                event['date'].day == selectedDate?.day)
            .toList();

      default:
        return allEvents;
    }
  }
}
