import 'package:agenda/DS/components/appBar/custom_appBar.dart';
import 'package:agenda/DS/components/calendario/calendario_view_model.dart';
import 'package:agenda/DS/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:agenda/DS/components/calendario/calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Home',
        backgroundColor: cyanColor,
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double calendarWidth = constraints.maxWidth * 0.9;
            double calendarHeight = constraints.maxHeight * 0.8;

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                width: calendarWidth,
                height: calendarHeight,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: cyanBlackColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const CalendarWidget(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Calendar(
      viewModel: CalendarioViewModel(
        size: CalendarioSize.large,
        style: CalendarioStyleColor.cyanColor,
        title: 'Agenda',
        startHour: 8,
        endHour: 18,
        onDateTimeSelected: null,
        listEvents: ListEvents.True,
        isWeekView: false,
      ),
    );
  }
}
