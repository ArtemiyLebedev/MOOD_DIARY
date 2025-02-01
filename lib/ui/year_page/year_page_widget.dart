import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:google_fonts/google_fonts.dart';
import '../month_page/month_page_widget.dart';

//Экран с календарем, где месяца в  GridView .
//Двойным нажатием на месяц можно перейтди на экран "MonthCalendarScreen"


class YearCalendarScreen extends StatefulWidget {
  const YearCalendarScreen({super.key});

  @override
  State<YearCalendarScreen> createState() => _YearCalendarScreenState();
}

class _YearCalendarScreenState extends State<YearCalendarScreen> {
  int selectedYear = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('$selectedYear',/////////////  YEAR name
            style: GoogleFonts.nunito(textStyle: TextStyle(
              color: Color.fromRGBO(76, 76, 105, 1),
              fontWeight: FontWeight.w800,
              fontSize: 26,)
            )
          ),
        ), //number Year
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
        ),
        itemCount: 12,
        itemBuilder: (context, index) => MonthCalendar(
          year: selectedYear,
          month: index + 1,
        ),
      ),
    );
  }
}

class MonthCalendar extends StatelessWidget {
  final int year;
  final int month;

  const MonthCalendar({super.key, required this.year, required this.month});

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(year, month, 1);
    final lastDay = DateTime(year, month + 1, 0);
    final monthName = DateFormat.LLLL('ru_RU').format(firstDay);
    final capitalizedMonthName =
        monthName[0].toUpperCase() + monthName.substring(1).toLowerCase();
    final daysInMonth = lastDay.day;
    final startingWeekday = firstDay.weekday;

    final today = DateTime.now();
    return GestureDetector(
      child: Column(
        children: [
          Row(
            children: [
              Text(capitalizedMonthName, /////////////  MONTH name
                  textAlign: TextAlign.start,
                  style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                    color: Color.fromRGBO(76, 76, 105, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ))),
            ],
          ),
          Expanded(
            child: Table(
              children: [
                ...List.generate(6, (weekIndex) {
                  return TableRow(
                    children: List.generate(7, (dayIndex) {
                      final dayNumber =
                          weekIndex * 7 + dayIndex + 1 - startingWeekday + 1;
                      final isCurrentDay = year == today.year &&
                          month == today.month &&
                          dayNumber == today.day;
                      if (dayNumber < 1 || dayNumber > daysInMonth) {
                        return Container();
                      }
                      return Container(
                        margin: EdgeInsets.all(2),
                        width: 18.36,
                        height: 18.36,
                        decoration: BoxDecoration(
                          color: isCurrentDay
                              ? Color.fromRGBO(255, 135, 2, 0.25)
                              : null,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '$dayNumber', //number of DAY
                            style: TextStyle(
                              fontSize: 10,
                              color: isCurrentDay
                                  ? Color.fromRGBO(76, 76, 105, 1)
                                  : null,
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
      onDoubleTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MonthCalendarScreen()));
      },
    );
  }
}